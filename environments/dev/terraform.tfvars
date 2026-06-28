# Dev Environment - Snowflake & Azure Data Infrastructure
environment         = "dev"
region              = "eastus"

# Snowflake
snowflake_account   = "xy12345.us-east-1"
warehouse_name      = "DEV_COMPUTE_WH"
warehouse_size      = "X-Small"
database_name       = "DEV_DB"
schema_name         = "RAW"
role_name           = "DEV_ROLE"

# Azure Synapse
synapse_workspace   = "synapse-dev-workspace"
synapse_sku         = "DW100c"
resource_group      = "rg-data-infra-dev"
location            = "East US"

# ADF
adf_name            = "adf-dev-pipeline"
adf_integration_rt  = "AutoResolveIntegrationRuntime"

# Tags
tags = {
  environment = "dev"
  project     = "data-infra"
  owner       = "data-engineering"
  managed_by  = "terraform"
}
