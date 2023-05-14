output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}
#output "key_vault_name" {
#    value = azurerm_key_vault.kv.name
#}
output "storage_account_name" {
    value = azurerm_storage_account.sa2.name
}
#output "policy_set_definition_name" {
#    value = azurerm_policy_set_definition.policyset.name
#}
output "storage_container_name" {
    value = azurerm_storage_container.sacontainer.name
}




