terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

resource "proxmox_vm_qemu" "terrform-vm" {
  name        = var.vm_name
  desc        = var.description
  target_node = var.target_node
  os_type     = "cloud-init"
  full_clone  = true
  memory      = var.memory
  sockets     = var.sockets
  cores       = var.cores
  cpu         = "host"
  scsihw      = "virtio-scsi-pci"
  clone       = var.k8s_source_template
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
  ipconfig0 = "ip=dhcp"
  sshkeys   = var.ssh_keys
}

