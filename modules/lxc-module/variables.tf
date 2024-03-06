# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "root_password" {
  description = "Root password inside the container"
  type        = string
}

variable "name" {
  description = "The name of the container that will be created"
  type        = string
}

variable "target_node" {
  description = "The node to use when creating container"
  type        = string
}

variable "source_template" {
  description = "The volume identifier that points to the OS template or backup file"
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
  description = "A number containing the amount of RAM to assign to the container (in MB)"
  type        = string
  default     = "1024"
}

variable "cores" {
  description = "The number of cores assigned to the container"
  type        = string
  default     = "1"
}

variable "ssh_keys" {
  description = "Multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax"
  type        = list(string)
  default     = null
}

variable "nameserver" {
  description = "Sets default DNS server for container"
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "The size of the created disk (in GB)"
  type        = string
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

variable "ip" {
  description = "The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), or 'dhcp'"
  type        = string
  default     = "dhcp"
}

variable "gw" {
  description = "The IPv4 address belonging to the network interface's default gateway"
  type        = string
  default     = null
}

variable "onboot" {
  description = "Whether to have the container startup after the PVE node starts."
  type        = bool
  default     = false
}
