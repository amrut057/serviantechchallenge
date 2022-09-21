########################################################################
# This module deploys infrastructure required to host techchallengeapp #
########################################################################

# deploy resource group
resource "azurerm_resource_group" "rg" {
  name = var.rg_name
  location = var.location
}

resource "azurerm_postgresql_server" "pg_server" {
  name = var.pg_server_name
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  sku_name = var.sku_name
  version = var.pg_version
  administrator_login = var.dbuser
  administrator_login_password = var.dbpassword
  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "main" {
  name                = "db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.pg_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
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
    commands = [ "./TechChallengeApp updatedb", "./TechChallengeApp serve"]
    ports {
        port = 3000
        protocol = "TCP"
    }
    environment_variables = {
      VTT_DBHOST = azurerm_postgresql_server.pg_server.fqdn
      VTT_DBPASSWORD = var.dbpassword
    }
  }
  depends_on = [
    azurerm_postgresql_server.pg_server,
    azurerm_postgresql_database.main
  ]
}