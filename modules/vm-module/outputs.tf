output "ip_address" {
  value = try(proxmox_vm_qemu.terraform-vm[0].default_ipv4_address, proxmox_vm_qemu.terraform-vm-provisioner[0].default_ipv4_address)
}
