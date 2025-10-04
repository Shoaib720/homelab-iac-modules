resource "aws_kms_key" "kms" {
  count = var.configs.global.kms_encryption != null ? 1 : 0
  description             = "Key for ECR"
  enable_key_rotation     = var.configs.global.kms_encryption.enable_key_rotation
  deletion_window_in_days = var.configs.global.kms_encryption.deletion_window_in_days
  tags = try(var.configs.global.tags, {})
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.configs.global.prefix}-${var.configs.global.kms_encryption.key_alias}-${var.configs.global.environment}"
  target_key_id = aws_kms_key.kms.key_id
}