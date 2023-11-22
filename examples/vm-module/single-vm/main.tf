terraform {
  required_version = ">= 1.0.0, < 2.0.0"
}

module "proxmox_vm" {
  source  = "../../../vm-module/"
  vm_name = var.vm_name
}
