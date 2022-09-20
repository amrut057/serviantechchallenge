########################################################################
# This module deploys infrastructure required to host techchallengeapp #
########################################################################

# deploy resource group
resource "azurerm_resource_group" "rg" {
  name = var.rg_name
  location = var.location
}

resource "azurerm_postgres_server" "pg_server" {
  name = var.pg_server_name
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  sku_name = var.sku_name
  version = var.version
  administrator_login = var.dbuser
  administrator_login_password = var.dbpassword
  ssl_enforcement_enabled = true
}

resource "azurerm_container_group" "container" {
  name = var.container_grp_name
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  os_type = "Linux"
  container {
    name = var.container_name
    image = var.image
    cpu = var.cpu
    memory = var.memory
    commands = [ "./TechChallengeApp serve"]
    ports {
        port = 3000
        protocol = "TCP"
    }
  }
}