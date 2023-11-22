# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "vm_name" {
  description = "The name of the VM that will be created"
  type        = string
  default     = "example-terraform-vm-module"
}
