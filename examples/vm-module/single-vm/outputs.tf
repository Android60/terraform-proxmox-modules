output "proxmox_vm_ip_address" {
  value = module.proxmox_vm.ip_address[0]
}
