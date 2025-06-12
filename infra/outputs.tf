output "vm_public_ip" {
  description = "External IP Address"
  value = yandex_compute_instance.vm_1.network_interface[0].nat_ip_address
}

output "vm_name" {
  description = "VM Name Default"
  value = yandex_compute_instance.vm_1.name
}