resource "yandex_compute_disk" "virtual_disk" {
  count = 3
  name       = "virtual-disk-${tostring(count.index+1)}"
  type       = var.vm_disk_set.disktype
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vm_web_resources.core
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.virtual_disk[*].id
    content {
      disk_id = secondary_disk.value
    }
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
  metadata = local.vm_metadata
}