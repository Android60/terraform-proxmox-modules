terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_timeout      = 900
}


module "proxmox_vm" {
  source         = "../../../modules/vm-module/"
  name           = var.vm_name
  target_node    = var.target_node
  clone_template = var.clone_template
  onboot         = true
  ciuser         = "debian"
}
