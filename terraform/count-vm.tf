data "yandex_compute_image" "vm_web_family" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "web" {

  name        = "netology-develop-platform-web-${var.test[count.index]}"
  platform_id = var.vm_web_platform_id

  count = length(var.test)

  resources {
    cores         = var.vm_web_resources.core
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
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

  metadata = {
    serial-port-enable = var.vm_web_metadata.serial-port
    ssh-keys           = "ubuntu:${var.vm_web_metadata.ssh}"
  }
}

resource "yandex_vpc_security_group" "test" {
  name        = "my security group"
  description = "security group for ingress traffic"
  network_id  = yandex_vpc_network.develop.id

  ingress {
    protocol       = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port   = 65535
  }
}