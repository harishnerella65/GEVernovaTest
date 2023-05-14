terraform {
  backend "azurerm" {
    subscription_id          = "37ed9c9a-0d39-4823-a06c-e8121b935f89"
    resource_group_name      = "rg-hello-tf-7f44c8d1-3623-ae05-3301-9f37378c9879"
    storage_account_name     = "tfstab619ffe351b8a08b"
    container_name           = "tfstatecontainer"
    key                      = "terraform.tfstate"
  }
}
resource "random_uuid" "uuid" {}

resource "azurerm_resource_group" "rg" {
  name     = "rg-hello-tf-${random_uuid.uuid.result}"
  location = var.location
}
#resource "azurerm_key_vault" "kv" {
#  name                        = "vernovatestkeyvault"
#  location                    = azurerm_resource_group.rg.location
#  resource_group_name         = azurerm_resource_group.rg.name
#  enabled_for_disk_encryption = true
#  tenant_id                   = data.azurerm_client_config.current.tenant_id
#  soft_delete_retention_days  = 7
#  purge_protection_enabled    = false
#
#  sku_name = "standard"
#
#  access_policy {
#    tenant_id = data.azurerm_client_config.current.tenant_id
#    object_id = data.azurerm_client_config.current.object_id
#
#    key_permissions = [
#      "Get",
#    ]
#
#    secret_permissions = [
#      "Get",
#    ]
#
#    storage_permissions = [
#      "Get",
#    ]
#  }
#}

resource "random_id" "storage_account" {
  byte_length = 8
}

resource "azurerm_storage_account" "sa2" {
  name                     = "tfsta${lower(random_id.storage_account.hex)}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_container" "sacontainer" {
  name                  = "tfstatecontainer2"
  storage_account_name  = "tfstab619ffe351b8a08b"
  container_access_type = "private"
}
#resource "azurerm_policy_set_definition" "policyset" {
#  name         = "vernovatestPolicySet"
#  policy_type  = "Custom"
#  display_name = "Vernova Test Policy Set"
#
#  parameters = <<PARAMETERS
#    {
#        "allowedLocations": {
#            "type": "Array",
#            "metadata": {
#                "description": "The list of allowed locations for resources.",
#                "displayName": "Allowed locations",
#                "strongType": "location"
#            }
#        }
#    }
#PARAMETERS
#
#  policy_definition_reference {
#    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
#    parameter_values     = <<VALUE
#    {
#      "listOfAllowedLocations": {"value": "[parameters('allowedLocations')]"}
#    }
#    VALUE
#  }
#}
