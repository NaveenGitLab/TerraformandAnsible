output "vm_ids" {
description = "The IDs of the virtual machines"
value = azurerm_virtual_machine.vm[*].id
}

output "public_ips" {
description = "the public IPaddresses if the virtual machines"
value = azurerm_public_ip.vm_public_ip[*].ip_address
}
