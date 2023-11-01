resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "vm_web_family" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "vm_web_resource_name" {
  name        = var.vm_web_name
# name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_resources.core
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
#   cores         = var.vm_web_cores
#   memory        = var.vm_web_memory
#   core_fraction = var.vm_web_core_fraction
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
# metadata = {
#   serial-port-enable = "var.vm_web_serial-port-enable"
#   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
#  }
  metadata = {
    serial-port-enable = var.vm_web_metadata.serial-port
    ssh-keys           = "ubuntu:${var.vm_web_metadata.ssh}"
  }
}
  
resource "yandex_compute_instance" "vm_db_resource_name" {
  name        = var.vm_db_name
# name        = local.vm_db_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_db_resources.core
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }

# resources {
#   cores         = var.vm_db_cores
#   memory        = var.vm_db_memory
#   core_fraction = var.vm_db_core_fraction
# }
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
# metadata = {
#   serial-port-enable = "var.vm_web_serial-port-enable"
#   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
# }
  metadata = {
    serial-port-enable = var.vm_web_metadata.serial-port
    ssh-keys           = "ubuntu:${var.vm_web_metadata.ssh}"
  }
  
}