# Prod Environment - Snowflake & Azure Data Infrastructure
environment         = "prod"
region              = "eastus"

# Snowflake
snowflake_account   = "xy12345.us-east-1"
warehouse_name      = "PROD_COMPUTE_WH"
warehouse_size      = "Medium"
database_name       = "PROD_DB"
schema_name         = "RAW"
role_name           = "PROD_ROLE"

# Azure Synapse
synapse_workspace   = "synapse-prod-workspace"
synapse_sku         = "DW500c"
resource_group      = "rg-data-infra-prod"
location            = "East US"

# ADF
adf_name            = "adf-prod-pipeline"
adf_integration_rt  = "AutoResolveIntegrationRuntime"

# Tags
tags = {
  environment = "prod"
  project     = "data-infra"
  owner       = "data-engineering"
  managed_by  = "terraform"
}
