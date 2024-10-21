resource "azurerm_log_analytics_workspace" "logAnalytics" {
  name                = "${var.project_name}-logAnalytics-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "ContainerEnvironment" {
  name                       = "${var.project_name}-containers-${terraform.workspace}"
  location                   = azurerm_resource_group.resourceGroup.location
  resource_group_name        = azurerm_resource_group.resourceGroup.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logAnalytics.id

  tags = {
    Costcenter  = var.costcenter
    Owner       = var.owner_name
    Environment = terraform.workspace
  }
}

resource "azurerm_container_app" "RevealSlides" {
  name                         = "${var.project_short_name}-reveal-slides-${terraform.workspace}"
  container_app_environment_id = azurerm_container_app_environment.ContainerEnvironment.id
  resource_group_name          = azurerm_resource_group.resourceGroup.name
  # TBD: needs to change to single for now - but multiple is required for this script to run, otherwise time-out!
  # TBD: set to Single after this bug is fixed:
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/20435
  revision_mode = "Single"

  # Never change the image of the container, as this is done in github actions!
  lifecycle {
    ignore_changes = [template[0].container[0], secret, revision_mode] #  ingress
  }

  template {
    container {
      name  = "revreveal-slides"
      image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      # Increase if the container side or CPU demands increase!
      cpu    = 0.25 # 0.5
      memory = "0.5Gi" # "1Gi"
    }
  }

  ingress {
    target_port      = 80
    external_enabled = true
    allow_insecure_connections = false # consider adding this
    traffic_weight {
      percentage = 100
      # TBD: remove when using single after this bug is fixed:
      # https://github.com/hashicorp/terraform-provider-azurerm/issues/20435
      latest_revision = true
    }
  }

  tags = {
    Costcenter  = var.costcenter
    Owner       = var.owner_name
    Environment = terraform.workspace
  }
}