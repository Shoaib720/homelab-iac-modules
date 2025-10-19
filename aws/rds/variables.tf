variable rds_instance_name { type = string }

variable subnet_ids { type = list(string) }

variable vpc_address_cidr { type = string }

variable rds_engine_version {
    default = "17.6"
}

variable rds_instance_class {
    default = "db.t3.medium"
}

variable rds_storage_in_gb {
    default = 20
}

variable postgres_default_database {
    default = "postgres"
    sensitive = true
}

variable postgres_admin_username {
    type = string
    sensitive = true
}

variable postgres_admin_password {
    type = string
    sensitive = true
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}