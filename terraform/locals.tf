locals {
  vm_metadata = {
    serial-port-enable = var.vm_web_metadata.serial-port
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}