# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "vm_name" {
  description = "The name of the VM that will be created"
  type        = string
}

variable "target_node" {
  description = "The node to use when creating VM"
  type        = string
}

variable "clone_template" {
  description = "The base VM from which to clone to create the new VM"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "The description for the VM that will be created"
  type        = string
  default     = "Managed by Terraform"
}

variable "memory" {
  description = "The amount of memory to allocate to the VM in Megabytes"
  type        = string
  default     = "1024"
}

variable "cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM"
  type        = string
  default     = "1"
}

variable "sockets" {
  description = "The number of CPU sockets to allocate to the VM"
  type        = string
  default     = "1"

}

variable "disk_size" {
  description = "The size of the created disk"
  type        = string
  default     = "16G"
}

variable "storage_pool" {
  description = "The name of the storage pool on which to store the disk."
  type        = string
  default     = "local-lvm"
}

variable "vlan" {
  description = "VLAN to use for network adapter"
  type        = string
  default     = "1"
}

variable "bridge" {
  description = "Bridge to which the network device should be attached"
  type        = string
  default     = "vmbr0"
}

variable "ssh_keys" {
  description = "Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user."
  type        = string
  default     = null
}

variable "nameserver" {
  description = "Sets default DNS server for guest"
  type        = string
  default     = ""
}

variable "remote_exec" {
  description = "Script to run when provisioning"
  type        = list(string)
  default     = []
}
