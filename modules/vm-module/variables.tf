# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
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
  type        = number
  default     = "16"
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

variable "ciuser" {
  description = "Override the default cloud-init user for provisioning."
  type        = string
  default     = null

}

variable "ssh_user" {
  description = "The user with which to connect to the guest for preprovisioning"
  type        = string
  default     = null
}

variable "ssh_privkey" {
  description = "The private key to use when connecting to the guest for provisioning"
  type        = string
  default     = null
}

variable "full_clone" {
  description = "Set to true to create a full clone, or false to create a linked clone"
  type        = bool
  default     = true
}

variable "cpu_type" {
  description = "The type of CPU to emulate in the Guest"
  type        = string
  default     = "host"
}

variable "scsi_controller_type" {
  description = "The SCSI controller type to emulate"
  type        = string
  default     = "virtio-scsi-pci"
}

variable "onboot" {
  description = "Whether to have the VM startup after the PVE node starts."
  type        = bool
  default     = false
}
