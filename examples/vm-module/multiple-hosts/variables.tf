# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "target_node" {
  description = "The node to use when creating VM"
  type        = string
  default     = "ibm-x3200-prox2"
}

variable "clone_template" {
  description = "The base VM from which to clone to create the new VM"
  type        = string
  default     = "debian11-cloudinit-template"
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

