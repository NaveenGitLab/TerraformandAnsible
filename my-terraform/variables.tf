variable "resource_group_name" {
description = "Name of the resource group"
type = string
}
variable "location" {
description = "Name of the resource group"
type = string
}
variable "vnet_name" {
description = "Name of the Vnet"
type = string
}

variable "subnet_name" {
description = "Name of the subnetVnet"
type = string
}

variable "vm_name_prefix" {
description = "Name of the Vm PrefixsubnetVnet"
type = string
}

variable "nic_name" {
description = "Name of the network interface"
type = string 
}


variable "vm_name" {
description = "Name of the virtual machine"
type = string
}


variable "vm_size" {
description = "Size of the network interface"
type = string
}


variable "admin_username" {
description = "Admin user Name of the VM"
type = string
}


variable "admin_password" {
description = "Admin password of the VM"
type = string
}


variable "path" {
description = "Path of SSH key"
type = string
}


variable "key_data" {
description = "publish key data"
type = string
}


variable "vm_count" {
description = "Number of VMs to create"
type = number
}

variable "vnet_address_space" {
description = "Number of VMs to create"
type        = list(any)
}

variable "subnet_prefix" {
description = "Number of VMs to create"

}








