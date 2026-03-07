variable configs {
    type = object({
        ami_prefix = string
        name = string
        key_pair = object({
            public_key_path = string
            private_key_path = string
        })
        instance_type = string
        ingress_rules = list(object({
            from_port   = number
            to_port     = number
            protocol    = string
            description = string
            cidr_blocks = list(string)
        }))
        tags = optional(map(string))
    })
}