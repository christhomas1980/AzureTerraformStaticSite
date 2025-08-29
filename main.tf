
 provider "azurerm" {
 features {}
   subscription_id = "924a9ee7-efa0-4c58-829f-33ed3329fe2f"
}
resource "azurerm_resource_group" "static_site_rg" {
 name     = "static-website-rg"
 location = "East US"
}
resource "azurerm_storage_account" "static_site_sa" {
 name                     = "staticwebsitestoragenew"
 resource_group_name      = azurerm_resource_group.static_site_rg.name
 location                 = azurerm_resource_group.static_site_rg.location
 account_tier             = "Standard"
 account_replication_type = "LRS"
 static_website {
   index_document     = "index.html"
   error_404_document = "404.html"
 }
}

resource "azurerm_storage_account_static_website" "static_site_sa" {
 storage_account_id = azurerm_storage_account.storage_account.id
 index_document      = "index.html"
 error_404_document  = "404.html"
}

output "static_website_url" {
 value = azurerm_storage_account.static_site_sa.primary_web_endpoint
}