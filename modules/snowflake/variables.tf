variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "warehouse_name" {
  description = "Snowflake virtual warehouse name"
  type        = string
}

variable "warehouse_size" {
  description = "Snowflake warehouse size (X-Small, Small, Medium, Large)"
  type        = string
  default     = "X-Small"
}

variable "database_name" {
  description = "Snowflake database name"
  type        = string
}

variable "schema_name" {
  description = "Snowflake schema name"
  type        = string
  default     = "RAW"
}

variable "role_name" {
  description = "Snowflake role for pipeline access"
  type        = string
}
