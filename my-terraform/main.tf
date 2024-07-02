resource "azurerm_resource_group" "main" {
name = var.resource_group_name
location = var.location
}

resource "azurerm_virtual_network" "main" {
name = var.vnet_name
address_space = var.vnet_address_space
location = azurerm_resource_group.main.location
resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
name  = var.subnet_name
resource_group_name = azurerm_resource_group.main.name
virtual_network_name = azurerm_virtual_network.main.name
address_prefixes = var.subnet_prefix
}


resource "azurerm_public_ip" "vm_public_ip" {
count = var.vm_count
name = "${var.vm_name_prefix}-public-ip-${count.index}"
location = azurerm_resource_group.main.location
resource_group_name = azurerm_resource_group.main.name
allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "main" {
count = var.vm_count
name =  "${var.vm_name_prefix}-nic-${count.index}"
location = azurerm_resource_group.main.location
resource_group_name = azurerm_resource_group.main.name

ip_configuration {
name  = "internal"
subnet_id = azurerm_subnet.main.id
private_ip_address_allocation = "Dynamic"
public_ip_address_id = azurerm_public_ip.vm_public_ip[count.index].id
}
}

resource "azurerm_virtual_machine" "vm" {
name = "${var.vm_name_prefix}-${count.index}"
location = azurerm_resource_group.main.location
resource_group_name = azurerm_resource_group.main.name
network_interface_ids = [azurerm_network_interface.main[count.index].id]
vm_size  =  var.vm_size
count = var.vm_count

storage_os_disk  {
name = "${var.vm_name_prefix}-azosdisk-${count.index}"
caching = "ReadWrite"
managed_disk_type = "Standard_LRS"
disk_size_gb = 30
create_option = "FromImage"
}


storage_image_reference {
publisher = "Canonical"
offer = "UbuntuServer"
sku = "18.04-LTS"
version = "latest"
}

os_profile {
computer_name = "${var.vm_name_prefix}-${count.index}"
admin_username = "adminuser"
admin_password = "P@ssw0rd1234"
}

os_profile_linux_config {
disable_password_authentication = true
ssh_keys {
path = var.path
key_data = var.key_data
}
}

boot_diagnostics {
enabled = true 
storage_uri ="https://tfbackendstorage011.blob.core.windows.net/"
}
}



