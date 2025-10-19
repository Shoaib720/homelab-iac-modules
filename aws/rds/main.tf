resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.rds_instance_name}-db-subnets"
  subnet_ids = var.subnet_ids  # replace with your subnets

  tags = merge(var.tags, {
    Name = "${var.rds_instance_name}-db-subnets"
  })
}

resource "aws_security_group" "postgres_security_group" {
  name        = "${var.rds_instance_name}-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = var.vpc_id  # replace with your actual VPC ID

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_address_cidr] # tighten down for prod use
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "postgres" {
  identifier                 = var.rds_instance_name
  engine                     = "postgres"
  engine_version              = var.rds_engine_version            # or latest supported
  instance_class             = var.rds_instance_class
  allocated_storage          = var.rds_storage_in_gb
  storage_type               = "gp3"
  db_name                    = var.postgres_default_database
  username                   = var.postgres_admin_username
  password                   = var.postgres_admin_password
  db_subnet_group_name       = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids     = [aws_security_group.postgres_security_group.id]
  publicly_accessible        = false
  deletion_protection        = false
  skip_final_snapshot        = false
  final_snapshot_identifier  = "${var.rds_instance_name}-final-${formatdate("YYYYMMDDhhmmss", timestamp())}"

  # Restore automatically from last snapshot if available
  snapshot_identifier        = try(data.aws_db_snapshot.latest_snapshot.id, null)

  backup_retention_period    = 0
  storage_encrypted          = true
  auto_minor_version_upgrade = true
  multi_az                   = false

  tags = merge(var.tags, {
    Name = "${var.rds_instance_name}"
  })

  lifecycle {
    ignore_changes = [
      snapshot_identifier,
      final_snapshot_identifier
    ]
  }
}