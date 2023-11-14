resource "yandex_compute_instance" "example_2" {

  depends_on  = [resource.yandex_compute_instance.web]

  for_each    = { for h in var.vm_set: index(var.vm_set, h) => h }
  name        = each.value.vm_name
  platform_id = var.vm_web_platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.disk
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_web_family.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }
  allow_stopping_for_update = true

  metadata = local.vm_metadata
}