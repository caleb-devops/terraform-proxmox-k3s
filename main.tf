locals {
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

  ansible_groups = ["${local.ansible_prefix}_server"]
}

resource "ansible_group" "k3s_cluster" {
  inventory_group_name = "${local.ansible_prefix}_cluster"
  children             = ["${local.ansible_prefix}_server", "${local.ansible_prefix}_agent"]
}

module "k3s" {
  # source  = "xunleii/k3s/module"
  # version = "~> v2.2.0"

  source = "github.com/caleb-devops/terraform-module-k3s"

  k3s_version = var.k3s_version
  name        = var.name_prefix

  generate_ca_certificates = true

  servers = {
    for instance in module.k3s_server :
    instance.hostname => {
      ip = instance.ip

      connection = merge(var.connection, {
        user = instance.username
      })

      flags  = ["--write-kubeconfig-mode '0644'"]
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
