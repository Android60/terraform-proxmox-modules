terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

# VM resource without provisioner
resource "proxmox_vm_qemu" "terrform-vm" {
  count       = length(var.remote_exec) > 0 ? 0 : 1
  name        = var.name
  desc        = var.description
  target_node = var.target_node
  os_type     = "cloud-init"
  full_clone  = true
  memory      = var.memory
  sockets     = var.sockets
  cores       = var.cores
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = var.clone_template
  agent       = 1
  disk {
    size    = var.disk_size
    type    = "scsi"
    storage = var.storage_pool
  }
  network {
    model  = "virtio"
    bridge = var.bridge
    tag    = var.vlan
  }

  # Cloud-init section
  ipconfig0  = "ip=dhcp"
  sshkeys    = var.ssh_keys
  nameserver = var.nameserver
}


# VM resource with provisioner
resource "proxmox_vm_qemu" "terrform-vm-provisioner" {
  count           = length(var.remote_exec) > 0 ? 1 : 0
  name            = var.name
  desc            = var.description
  target_node     = var.target_node
  os_type         = "cloud-init"
  full_clone      = var.full_clone
  memory          = var.memory
  sockets         = var.sockets
  cores           = var.cores
  cpu             = var.cpu_type
  scsihw          = var.scsi_controller_type
  clone           = var.clone_template
  agent           = 1
  ssh_private_key = var.ssh_privkey
  ssh_user        = var.ssh_user
  disk {
    size    = var.disk_size
    type    = "scsi"
    storage = var.storage_pool
  }
  network {
    model  = "virtio"
    bridge = var.bridge
    tag    = var.vlan
  }

  # Cloud-init section
  ipconfig0  = "ip=dhcp"
  sshkeys    = var.ssh_keys
  nameserver = var.nameserver


  provisioner "remote-exec" {
    inline = var.remote_exec
    connection {
      type        = "ssh"
      user        = self.ssh_user
      private_key = self.ssh_private_key
      host        = self.ssh_host
      port        = self.ssh_port
    }
  }
}
