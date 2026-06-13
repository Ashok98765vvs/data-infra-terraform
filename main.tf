# main.tf
# Snowflake Data Infrastructure - Terraform
# Author: Ashok Chowdary

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "snowflake/data-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "snowflake" {
  account = var.snowflake_account
  role    = "SYSADMIN"
}

# ── Databases ───────────────────────────────────────────────────────────────
resource "snowflake_database" "raw" {
  name    = "RAW_DB"
  comment = "Raw ingested data - landing zone"
}

resource "snowflake_database" "staging" {
  name    = "STAGING_DB"
  comment = "dbt staging models"
}

resource "snowflake_database" "prod" {
  name    = "PROD_DB"
  comment = "Production data marts"
}

# ── Warehouses ──────────────────────────────────────────────────────────────
resource "snowflake_warehouse" "etl_wh" {
  name           = "ETL_WH"
  warehouse_size = "SMALL"
  auto_suspend   = 60
  auto_resume    = true
  comment        = "Used for Airflow/Fivetran ETL loads"
}

resource "snowflake_warehouse" "dbt_wh" {
  name           = "DBT_WH"
  warehouse_size = "MEDIUM"
  auto_suspend   = 120
  auto_resume    = true
  comment        = "Used for dbt transformations"
}

resource "snowflake_warehouse" "analyst_wh" {
  name           = "ANALYST_WH"
  warehouse_size = "X-SMALL"
  auto_suspend   = 300
  auto_resume    = true
  comment        = "Used by analysts for ad-hoc queries"
}

# ── Roles ─────────────────────────────────────────────────────────────────
resource "snowflake_role" "etl_role" {
  name    = "ETL_ROLE"
  comment = "Role for ETL service accounts (Airflow, Fivetran)"
}

resource "snowflake_role" "dbt_role" {
  name    = "DBT_ROLE"
  comment = "Role for dbt transformations"
}

resource "snowflake_role" "analyst_role" {
  name    = "ANALYST_ROLE"
  comment = "Read-only role for analysts"
}

# ── Grants ────────────────────────────────────────────────────────────────
resource "snowflake_warehouse_grant" "etl_wh_grant" {
  warehouse_name = snowflake_warehouse.etl_wh.name
  privilege      = "USAGE"
  roles          = [snowflake_role.etl_role.name]
}

resource "snowflake_warehouse_grant" "dbt_wh_grant" {
  warehouse_name = snowflake_warehouse.dbt_wh.name
  privilege      = "USAGE"
  roles          = [snowflake_role.dbt_role.name]
}

resource "snowflake_database_grant" "analyst_db_grant" {
  database_name = snowflake_database.prod.name
  privilege     = "USAGE"
  roles         = [snowflake_role.analyst_role.name]
}
