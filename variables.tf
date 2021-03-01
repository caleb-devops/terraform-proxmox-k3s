variable "target_node" {
  description = "The name of the Proxmox Node on which to place the VM"
  type        = string
  default     = "pve"
}

variable "pool" {
  description = "The destination resource pool for the new VM"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a name beginning with the specified prefix"
  type        = string
}

variable "connection" {
  description = "Provisioner connection settings"
  type        = object({})
  sensitive   = true
  default = {
    type  = "ssh"
    agent = true
  }
}

#####################################################
# VM Qemu Resource
#####################################################

variable "clone" {
  description = "The base VM from which to clone to create the new VM"
  type        = string
}

variable "numa" {
  description = "Whether to enable Non-Uniform Memory Access in the guest"
  type        = bool
  default     = false
}

variable "ciuser" {
  description = "Override the default cloud-init user for provisioning"
  type        = string
}

variable "cipassword" {
  description = "Override the default cloud-init user's password"
  type        = string
  sensitive   = true
  default     = null
}

variable "searchdomain" {
  description = "Sets default DNS search domain suffix"
  type        = string
  default     = null
}

variable "nameserver" {
  description = "Sets default DNS server for guest"
  type        = string
  default     = null
}

variable "sshkeys" {
  description = "Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user"
  type        = string
}

############################
# K3S Server
############################

variable "server_count" {
  description = "The number of K3S server nodes to create"
  type        = number
}

variable "server_cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM"
  type        = number
  default     = 1
}

variable "server_sockets" {
  description = "The number of CPU sockets to allocate to the VM"
  type        = number
  default     = 1
}

variable "server_memory" {
  description = "The amount of memory to allocate to the VM in Megabytes"
  type        = number
  default     = 512
}

variable "server_disks" {
  description = "VM disk config"
  type        = list(object({}))
  default     = [{}]
}

variable "server_networks" {
  description = "VM network adapter config"
  type        = list(object({}))
  default     = [{}]
}

############################
# K3S Agent
############################

variable "agent_count" {
  description = "The number of K3S agent nodes to create"
  type        = number
}

variable "agent_cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM"
  type        = number
  default     = 1
}

variable "agent_sockets" {
  description = "The number of CPU sockets to allocate to the VM"
  type        = number
  default     = 1
}

variable "agent_memory" {
  description = "The amount of memory to allocate to the VM in Megabytes"
  type        = number
  default     = 512
}

variable "agent_disks" {
  description = "VM disk config"
  type        = list(object({}))
  default     = [{}]
}

variable "agent_networks" {
  description = "VM network adapter config"
  type        = list(object({}))
  default     = [{}]
}