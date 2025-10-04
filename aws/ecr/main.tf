resource "aws_ecr_repository" "ecr" {
    for_each = { for idx, cfg in var.configs.repositories : "${cfg.name}" => cfg }
    name                 = "${var.configs.global.prefix}-${each.key}-${var.configs.global.environment}"
    image_tag_mutability = each.value.image_tag_mutability

    image_scanning_configuration {
        scan_on_push = each.value.enable_image_scanning
    }

    dynamic "image_tag_mutability_exclusion_filter" {
        for_each = contains(
        ["MUTABLE_WITH_EXCLUSION", "IMMUTABLE_WITH_EXCLUSION"],
        each.value.image_tag_mutability
        ) ? each.value.exclusion_filters : []

        content {
        filter      = image_tag_mutability_exclusion_filter.value.filter
        filter_type = image_tag_mutability_exclusion_filter.value.filter_type
        }
    }

    dynamic "encryption_configuration" {
        count = var.configs.global.kms_encryption != null ? 1 : 0
        content {
            encryption_type = "KMS"
            kms_key = aws_kms_key.kms.arn
        }
    }

    tags = try(var.configs.global.tags, {})
}