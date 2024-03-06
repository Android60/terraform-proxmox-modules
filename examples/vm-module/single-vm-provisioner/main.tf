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
  name           = var.vm_name           # Name for new VM
  target_node    = var.target_node       # Create VM on that node
  clone_template = var.clone_template    # Template to use when cloning VM
  remote_exec    = var.remote_exec       # Script to execute on provisioning
  ssh_privkey    = file("~/.ssh/id_rsa") # Private key to use when provisioning
  ssh_user       = "debian"              # SSH user to use
  ciuser         = "debian"
}
