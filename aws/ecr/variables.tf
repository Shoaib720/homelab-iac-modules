variable "configs" {
  type = object({
    global = object({
      prefix = string
      environment = string
      kms_encryption = object({
        key_alias = string
        enable_key_rotation = bool
        deletion_window_in_days = number
      })
      tags = optional(map(string))
    })
    repositories = list(object({
        name = string
        image_tag_mutability = optional(string)
        enable_image_scanning = optional(bool)
        exclusion_filters = optional(list(object({
            filter_type = string
            filter = string
        })))
    }))
  })
}