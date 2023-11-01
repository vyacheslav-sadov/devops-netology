variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
}

#variable "vm_db_cores" {
#  type        = number
#  default     = 2
#}
#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#}
#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#}

variable "vm_db_resources" {
  type          = map
  default       = {
  core          = 2
  memory        = 2
  core_fraction = 20
  }
}