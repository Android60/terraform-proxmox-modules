# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "lxc_name" {
  description = "The name of the VM that will be created"
  type        = string
  default     = "example-terraform-lxc-module"
}

variable "target_node" {
  description = "The node to use when creating VM"
  type        = string
  default     = "ibm-x3200-prox2"
}

variable "source_template" {
  description = "The base VM from which to clone to create the new VM"
  type        = string
  default     = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}

variable "root_password" {
  description = "Root password inside the container"
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

