locals {

vm_web_name = "netology-${var.vpc_name}-${var.vm_web_resource_name}-${var.vm_web_role-web}"
vm_db_name = "netology-${var.vpc_name}-${var.vm_db_resource_name}-${var.vm_web_role-db}"
}
