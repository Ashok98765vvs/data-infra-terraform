# Snowflake Module - Warehouse, Database, Schema, Role
terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}

resource "snowflake_warehouse" "this" {
  name           = var.warehouse_name
  warehouse_size = var.warehouse_size
  auto_suspend   = 60
  auto_resume    = true
  comment        = "Managed by Terraform - ${var.environment} environment"
}

resource "snowflake_database" "this" {
  name    = var.database_name
  comment = "Managed by Terraform"
}

resource "snowflake_schema" "this" {
  database = snowflake_database.this.name
  name     = var.schema_name
  comment  = "Raw ingestion schema"
}

resource "snowflake_role" "this" {
  name    = var.role_name
  comment = "Role for ${var.environment} data pipeline access"
}

resource "snowflake_warehouse_grant" "usage" {
  warehouse_name = snowflake_warehouse.this.name
  privilege      = "USAGE"
  roles          = [snowflake_role.this.name]
}
