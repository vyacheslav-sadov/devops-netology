output "netology-develop-platform-db" {
  value = yandex_compute_instance.vm_db_resource_name.network_interface[0].nat_ip_address
  description = "vm external ip"
}
output "netology-develop-platform-web" {
  value = yandex_compute_instance.vm_web_resource_name.network_interface[0].nat_ip_address
  description = "vm external ip"
}