locals {
  kubeconfig = templatefile("${path.module}/templates/kubeconfig.tpl", {
    kubeconfig_name        = var.name_prefix
    api_endpoint           = module.k3s.kubernetes.api_endpoint
    cluster_ca_certificate = base64encode(module.k3s.kubernetes.cluster_ca_certificate)
    client_certificate     = base64encode(module.k3s.kubernetes.client_certificate)
    client_key             = base64encode(module.k3s.kubernetes.client_key)
  })

  ansible_prefix = replace(var.name_prefix, "-", "_")
}

module "k3s_server" {
  source = "github.com/caleb-devops/terraform-proxmox-ci-vm"

  count = var.server_count
  name  = "${var.name_prefix}-server-${count.index + 1}"

  target_node = var.target_node
  pool        = var.pool

  clone = var.clone
  numa  = var.numa

  sockets = var.server_sockets
  cores   = var.server_cores
  memory  = var.server_memory

  disks    = var.server_disks
  networks = var.server_networks

  ciuser       = var.ciuser
  cipassword   = var.cipassword
  searchdomain = var.searchdomain
  nameserver   = var.nameserver
  sshkeys      = var.sshkeys

  ipconfig0 = "ip=dhcp"

  connection = var.connection

  ansible_groups = ["${local.ansible_prefix}_server"]
}

module "k3s_agent" {
  source = "github.com/caleb-devops/terraform-proxmox-ci-vm"

  count = var.agent_count

  target_node = var.target_node
  pool        = var.pool

  name  = "${var.name_prefix}-agent-${count.index + 1}"
  clone = var.clone
  numa  = var.numa

  sockets = var.agent_sockets
  cores   = var.agent_cores
  memory  = var.agent_memory

  disks    = var.agent_disks
  networks = var.agent_networks

  ciuser       = var.ciuser
  cipassword   = var.cipassword
  searchdomain = var.searchdomain
  nameserver   = var.nameserver
  sshkeys      = var.sshkeys

  ipconfig0 = "ip=dhcp"

  connection = var.connection

  ansible_groups = ["${local.ansible_prefix}_agent"]
}

module "k3s" {
  source  = "xunleii/k3s/module"
  version = "~> 3.0"

  k3s_version = var.k3s_version

  generate_ca_certificates = true

  servers = {
    for instance in module.k3s_server :
    instance.hostname => {
      ip = instance.ip

      connection = merge(var.connection, {
        user = instance.username
      })

      flags  = ["--write-kubeconfig-mode '0644'", "--disable traefik"]
      taints = { "node-role.kubernetes.io/master" = "server:NoSchedule" }
    }
  }

  agents = {
    for instance in module.k3s_agent :
    instance.hostname => {
      ip = instance.ip

      connection = merge(var.connection, {
        user = instance.username
      })
    }
  }
}

resource "local_file" "kubeconfig" {
  count = var.write_kubeconfig ? 1 : 0

  content              = local.kubeconfig
  filename             = substr(var.kubeconfig_output_path, -1, 1) == "/" ? "${var.kubeconfig_output_path}kubeconfig_${var.name_prefix}" : var.kubeconfig_output_path
  file_permission      = var.kubeconfig_file_permission
  directory_permission = "0755"
}
