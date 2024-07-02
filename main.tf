
provider "azurerm" {
features {}
}

module "azure_vm" {
source =".//my-terraform"

resource_group_name = "myResourceGroup1"
vm_count            = 3
location            = "East US"
vnet_name           = "myVnet"
vnet_address_space  = ["10.0.0.0/16"]
subnet_name         = "mySubnet"
subnet_prefix       = ["10.0.1.0/24"]
nic_name            = "myNIC1"
vm_name_prefix      = "myVm"
vm_name             = "myVM"
vm_size             = "Standard_DS1_v2"
admin_username      = "adminuser"
admin_password      = "Password1234!"
path                = "/home/adminuser/.ssh/authorized_keys"
key_data            = file("C:/Users/pulkit/.ssh/id_rsa.pub")
}

output "vm_ids" {
value = module.azure_vm.vm_ids
}
output "public_ips" {
value=module.azure_vm.public_ips
}


