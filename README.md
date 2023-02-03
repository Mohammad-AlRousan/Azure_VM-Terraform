# Azure Virtual Machines Terraform Module

Terraform module to deploy azure Windows or Linux virtual machines with Public IP, proximity placement group, Availability Set, boot diagnostics, data disks, and Network Security Group support. It supports existing ssh keys or generates ssh key pairs if required for Linux VM's. It creates random passwords as well if you are not providing the custom password for Windows VM's.

This module supports to use existing NSG group. To enable this feature, specify the argument `existing_network_security_group_id` with a valid resource id of the current NSG group and remove all NSG inbound rules from the module.

## Module

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_os"></a> [os](#module\_os) | ./os | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_backup_protected_vm.vm_backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_storage_account.vm_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_virtual_machine.vm_linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_machine.vm_windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_machine_extension.extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.extensions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [random_id.vm_sa](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_public_ip.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure. | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The admin username of the VM that will be deployed. | `string` | `"azureuser"` | no |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines how an IP address is assigned. Options are Static or Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_as_platform_fault_domain_count"></a> [as\_platform\_fault\_domain\_count](#input\_as\_platform\_fault\_domain\_count) | (Optional) Specifies the number of fault domains that are used. Defaults to `2`. Changing this forces a new resource to be created. | `number` | `2` | no |
| <a name="input_as_platform_update_domain_count"></a> [as\_platform\_update\_domain\_count](#input\_as\_platform\_update\_domain\_count) | (Optional) Specifies the number of update domains that are used. Defaults to `2`. Changing this forces a new resource to be created. | `number` | `2` | no |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | (Optional) Specifies the id of the backup policy to use | `string` | `""` | no |
| <a name="input_backup_vault_resource_group_name"></a> [backup\_vault\_resource\_group\_name](#input\_backup\_vault\_resource\_group\_name) | (Optional) The name of the resource group in which to create the Recovery Services Vault. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | (Optional) Enable or Disable boot diagnostics. | `bool` | `false` | no |
| <a name="input_boot_diagnostics_sa_type"></a> [boot\_diagnostics\_sa\_type](#input\_boot\_diagnostics\_sa\_type) | (Optional) Storage account type for boot diagnostics. | `string` | `"Standard_LRS"` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | The custom data to supply to the machine. This can be used as a cloud-init for Linux systems. | `string` | `""` | no |
| <a name="input_data_disk_size_gb"></a> [data\_disk\_size\_gb](#input\_data\_disk\_size\_gb) | Storage data disk size size. | `number` | `30` | no |
| <a name="input_data_sa_type"></a> [data\_sa\_type](#input\_data\_sa\_type) | Data Disk Storage Account type. | `string` | `"Standard_LRS"` | no |
| <a name="input_delete_data_disks_on_termination"></a> [delete\_data\_disks\_on\_termination](#input\_delete\_data\_disks\_on\_termination) | Delete data disks when machine is terminated. | `bool` | `false` | no |
| <a name="input_delete_os_disk_on_termination"></a> [delete\_os\_disk\_on\_termination](#input\_delete\_os\_disk\_on\_termination) | Delete datadisk when machine is terminated. | `bool` | `false` | no |
| <a name="input_diagnostic_setting"></a> [diagnostic\_setting](#input\_diagnostic\_setting) | Diagnostic setting configuration | <pre>map(<br>    object({<br>      log_type             = optional(list(string))<br>      log_analytics_workspace_id = optional(string)<br>      metric_type          = optional(list(string))<br>      log_metric_retention = optional(number)<br>      storage_account_id   = optional(string)<br>    })<br>  )</pre> | `{}` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Enable accelerated networking on Network interface. | `bool` | `false` | no |
| <a name="input_enable_ssh_key"></a> [enable\_ssh\_key](#input\_enable\_ssh\_key) | (Optional) Enable ssh key authentication in Linux virtual Machine. | `bool` | `true` | no |
| <a name="input_external_boot_diagnostics_storage"></a> [external\_boot\_diagnostics\_storage](#input\_external\_boot\_diagnostics\_storage) | (Optional) The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files. Set this argument would disable the creation of `azurerm_storage_account` resource. | <pre>object({<br>    uri = string<br>  })</pre> | `null` | no |
| <a name="input_extra_disks"></a> [extra\_disks](#input\_extra\_disks) | (Optional) List of extra data disks attached to each virtual machine. | <pre>list(object({<br>    name = string<br>    size = number<br>  }))</pre> | `[]` | no |
| <a name="input_extra_ssh_keys"></a> [extra\_ssh\_keys](#input\_extra\_ssh\_keys) | Same as ssh\_key, but allows for setting multiple public keys. Set your first key in ssh\_key, and the extras here. | `list(string)` | `[]` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `"SystemAssigned"` | no |
| <a name="input_is_marketplace_image"></a> [is\_marketplace\_image](#input\_is\_marketplace\_image) | Boolean flag to notify when the image comes from the marketplace. | `bool` | `false` | no |
| <a name="input_is_windows_image"></a> [is\_windows\_image](#input\_is\_windows\_image) | Boolean flag to notify when the custom image is windows based. | `bool` | `false` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows\_Client and Windows\_Server | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location in which the resources will be created. | `string` | `null` | no |
| <a name="input_nb_data_disk"></a> [nb\_data\_disk](#input\_nb\_data\_disk) | (Optional) Number of the data disks attached to each virtual machine. | `number` | `0` | no |
| <a name="input_nb_instances"></a> [nb\_instances](#input\_nb\_instances) | Specify the number of vm instances. | `number` | `1` | no |
| <a name="input_nb_public_ip"></a> [nb\_public\_ip](#input\_nb\_public\_ip) | Number of public IPs to assign corresponding to one IP per vm. Set to 0 to not assign any public IP addresses. | `number` | `1` | no |
| <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group) | The network security group we'd like to bind with virtual machine. Set this variable will disable the creation of `azurerm_network_security_group` and `azurerm_network_security_rule` resources. | <pre>object({<br>    id = string<br>  })</pre> | `null` | no |
| <a name="input_os_profile_secrets"></a> [os\_profile\_secrets](#input\_os\_profile\_secrets) | Specifies a list of certificates to be installed on the VM, each list item is a map with the keys source\_vault\_id, certificate\_url and certificate\_store. | `list(map(string))` | `[]` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Optional) Private IP address. | `string` | `""` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | (Optional) Private IP address allocation. | `string` | `"Dynamic"` | no |
| <a name="input_public_ip_dns"></a> [public\_ip\_dns](#input\_public\_ip\_dns) | Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb\_public\_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string. | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | Defines the SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Basic"` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | (Optional) Specifies the name of the Recovery Services Vault to use. Changing this forces a new resource to be created | `string` | `""` | no |
| <a name="input_remote_port"></a> [remote\_port](#input\_remote\_port) | Remote tcp port to be used for access to the vms created via the nsg applied to the nics. | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_source_address_prefixes"></a> [source\_address\_prefixes](#input\_source\_address\_prefixes) | (Optional) List of source address prefixes allowed to access var.remote\_port. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Path to the public key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash.e.g. c : /home/id\_rsa.pub. | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_ssh_key_values"></a> [ssh\_key\_values](#input\_ssh\_key\_values) | List of Public SSH Keys values to be used for ssh access to the VMs. | `list(string)` | `[]` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Defines the type of storage account to be created. Valid options are Standard\_LRS, Standard\_ZRS, Standard\_GRS, Standard\_RAGRS, Premium\_LRS. | `string` | `"Premium_LRS"` | no |
| <a name="input_storage_os_disk_size_gb"></a> [storage\_os\_disk\_size\_gb](#input\_storage\_os\_disk\_size\_gb) | (Optional) Specifies the size of the data disk in gigabytes. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |
| <a name="input_vm_extension"></a> [vm\_extension](#input\_vm\_extension) | (Deprecated) This variable has been superseded by the `vm_extensions`. Argument to create `azurerm_virtual_machine_extension` resource, the argument descriptions could be found at [the document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension). | <pre>object({<br>    name                        = string<br>    publisher                   = string<br>    type                        = string<br>    type_handler_version        = string<br>    auto_upgrade_minor_version  = optional(bool)<br>    automatic_upgrade_enabled   = optional(bool)<br>    failure_suppression_enabled = optional(bool, false)<br>    settings                    = optional(string)<br>    protected_settings          = optional(string)<br>    protected_settings_from_key_vault = optional(object({<br>      secret_url      = string<br>      source_vault_id = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_vm_extensions"></a> [vm\_extensions](#input\_vm\_extensions) | Argument to create `azurerm_virtual_machine_extension` resource, the argument descriptions could be found at [the document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension). | <pre>set(object({<br>    name                        = string<br>    publisher                   = string<br>    type                        = string<br>    type_handler_version        = string<br>    auto_upgrade_minor_version  = optional(bool)<br>    automatic_upgrade_enabled   = optional(bool)<br>    failure_suppression_enabled = optional(bool, false)<br>    settings                    = optional(string)<br>    protected_settings          = optional(string)<br>    protected_settings_from_key_vault = optional(object({<br>      secret_url      = string<br>      source_vault_id = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_vm_hostname"></a> [vm\_hostname](#input\_vm\_hostname) | local name of the Virtual Machine. | `string` | `"myvm"` | no |
| <a name="input_vm_os_id"></a> [vm\_os\_id](#input\_vm\_os\_id) | The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is\_windows\_image = true for windows custom images. | `string` | `""` | no |
| <a name="input_vm_os_offer"></a> [vm\_os\_offer](#input\_vm\_os\_offer) | The name of the offer of the image that you want to deploy. This is ignored when vm\_os\_id or vm\_os\_simple are provided. | `string` | `""` | no |
| <a name="input_vm_os_publisher"></a> [vm\_os\_publisher](#input\_vm\_os\_publisher) | The name of the publisher of the image that you want to deploy. This is ignored when vm\_os\_id or vm\_os\_simple are provided. | `string` | `""` | no |
| <a name="input_vm_os_simple"></a> [vm\_os\_simple](#input\_vm\_os\_simple) | Specify UbuntuServer, WindowsServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm\_os\_publisher, vm\_os\_offer, and vm\_os\_sku. | `string` | `""` | no |
| <a name="input_vm_os_sku"></a> [vm\_os\_sku](#input\_vm\_os\_sku) | The sku of the image that you want to deploy. This is ignored when vm\_os\_id or vm\_os\_simple are provided. | `string` | `""` | no |
| <a name="input_vm_os_version"></a> [vm\_os\_version](#input\_vm\_os\_version) | The version of the image that you want to deploy. This is ignored when vm\_os\_id or vm\_os\_simple are provided. | `string` | `"latest"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Specifies the size of the virtual machine. | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | The subnet id of the virtual network where the virtual machines will reside. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) The Availability Zone which the Virtual Machine should be allocated in, only one zone would be accepted. If set then this module won't create `azurerm_availability_set` resource. Changing this forces a new resource to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_set_id"></a> [availability\_set\_id](#output\_availability\_set\_id) | Id of the availability set where the vms are provisioned. If `var.zones` is set, this output will return empty string. |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | ids of the vm nics provisoned. |
| <a name="output_network_interface_private_ip"></a> [network\_interface\_private\_ip](#output\_network\_interface\_private\_ip) | private ip addresses of the vm nics |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The actual ip address allocated for the resource. |
| <a name="output_public_ip_dns_name"></a> [public\_ip\_dns\_name](#output\_public\_ip\_dns\_name) | fqdn to connect to the first vm provisioned. |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | id of the public ip address provisoned. |
| <a name="output_vm_identity"></a> [vm\_identity](#output\_vm\_identity) | map with key `Virtual Machine Id`, value `list of identity` created for the Virtual Machine. |
| <a name="output_vm_ids"></a> [vm\_ids](#output\_vm\_ids) | Virtual machine ids created. |
| <a name="output_vm_names"></a> [vm\_names](#output\_vm\_names) | Virtual machine names created. |
| <a name="output_vm_zones"></a> [vm\_zones](#output\_vm\_zones) | map with key `Virtual Machine Id`, value `list of the Availability Zone` which the Virtual Machine should be allocated in. |

## Module Usage
```terraform
module "ubuntuservers" {
  source                           = "./virtual_machine"
  vm_hostname                      = "mylinuxvm"
  resource_group_name              = module.jump_server_resource_group.resource_group.name
  location                         = local.location
  admin_username                   = var.admin_username
  admin_password                   = local.admin_password
  vm_os_simple                     = var.vm_os_simple_1
  public_ip_dns                    = ["ubuntusimplevmips-${random_id.ip_dns.hex}"]
  vnet_subnet_id                   = lookup(module.vnet.subnet_map, "snet-jump")
  allocation_method                = "Static"
  public_ip_sku                    = "Standard"
  enable_accelerated_networking    = true
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true
  enable_ssh_key                   = false
  boot_diagnostics                 = true
  ssh_key                          = fileexists("~/.ssh/id_rsa.pub") ? "~/.ssh/id_rsa.pub" : ""
  extra_ssh_keys                   = local.ubuntu_ssh_keys
  vm_size                          = "Standard_DS2_V2"
  nb_data_disk                     = 2
  vm_extensions                    = local.linux_vm_extensions
  identity_type                    = "SystemAssigned"
  recovery_vault_name              = module.backup.recovery_vault_name
  backup_policy_id                 = module.vm_backup_policy.vm_policy_id
  backup_vault_resource_group_name = module.backup_resource_group.resource_group.name
  diagnostic_setting               = local.diagnostic_setting
  tags                             = local.extra_tags
}
module "windowsservers" {
  source                           = "./virtual_machine"
  is_windows_image                 = true
  resource_group_name              = module.jump_server_resource_group.resource_group.name
  location                         = local.location
  vm_hostname                      = "mywinvm"
  admin_password                   = local.admin_password
  public_ip_dns                    = ["pip1", "pip2"]
  nb_public_ip                     = 1
  nb_instances                     = 1
  vm_os_publisher                  = "microsoftwindowsdesktop"
  vm_os_offer                      = "windows-11"
  vm_os_sku                        = "win11-21h2-pro"
  vm_size                          = "Standard_DS2_V2"
  boot_diagnostics                 = true
  vnet_subnet_id                   = lookup(module.vnet.subnet_map, "snet-jump")
  recovery_vault_name              = module.backup.recovery_vault_name
  backup_policy_id                 = module.vm_backup_policy.vm_policy_id
  backup_vault_resource_group_name = module.backup_resource_group.resource_group.name
  diagnostic_setting               = local.diagnostic_setting
  tags                             = local.extra_tags
}
```