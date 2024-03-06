terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.48.1"
    }
  }
}

provider "proxmox" {

}

module "proxmox_vm" {
  source         = "../../../modules/vm-module/"
  name           = "terraform-vm-module-example"
  target_node    = var.target_node
  clone_template = var.clone_template
}

module "lxc_ct" {
  source          = "../../../modules/lxc-module"
  name            = "terraform-lxc-module-example"
  root_password   = var.root_password
  target_node     = var.target_node
  source_template = var.source_template
}
