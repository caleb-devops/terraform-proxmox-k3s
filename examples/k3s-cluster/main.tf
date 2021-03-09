provider "proxmox" {
  pm_parallel     = 3
  pm_tls_insecure = true
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
}

module "k3s_cluster" {
  source = "../.."

  name_prefix = "k3s-cluster"

  pool  = "terraform"
  clone = "ubuntu-2004-cloudinit-template"

  numa = true

  ciuser  = "ubuntu"
  sshkeys = file("~/.ssh/id_ed25519.pub")

  # K3S Server
  server_count   = 1
  server_sockets = 2
  server_memory  = 2048

  server_disks = [
    {
      size = "20G"
    }
  ]

  server_networks = [
    {
      bridge = "vmbr2"
    }
  ]

  # K3S Agent
  agent_count   = 2
  agent_sockets = 2
  agent_memory  = 2048

  agent_disks = [
    {
      size = "20G"
    }
  ]

  agent_networks = [
    {
      bridge = "vmbr2"
    }
  ]
}
