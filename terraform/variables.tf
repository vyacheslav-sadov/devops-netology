variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
  
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}
variable "vm_web_resource_name" {
  type        = string
  default     = "platform"
}
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "vm_web_role-web" {
  type        = string.
  default     = "web"
}
variable "vm_web_resources" {
  type          = map
  default       = {
  core          = 2
  memory        = 1
  core_fraction = 5
  }
} 
variable "vm_web_preemptible" {
  type        = bool
  default     = true
}
variable "vm_web_nat" {
  type        = bool
  default     = true
}
variable "vm_web_metadata" {
  type        = map
  default     = {
  serial-port = 1
  ssh         = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJpTKXqDZGrs40LO//3/T1ExHQoThQ9GHmVnwT2b+n2L user@test-VM"
  }
}
variable "test" {
  type        = list(number)
  default     = ["1", "2"]
}

variable "vm_set" {
  type        = list(object({
    vm_name   = string
    cpu       = number
    ram       = number
    disk      = number
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 1
      disk    = 5

    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 2
      disk    = 20
    }
  ]
}

variable "vm_disk_set" {
  type = object ( {disktype = string, disksize = number} )
  default = {
    disktype = "network-hdd"
    disksize = 5
  }
} 
variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJpTKXqDZGrs40LO//3/T1ExHQoThQ9GHmVnwT2b+n2L user@test-VM"
}