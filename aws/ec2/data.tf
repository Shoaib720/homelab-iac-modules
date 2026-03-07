data "aws_ami" "latest_ami" {
  owners      = ["self"] # or your AWS account ID
  most_recent = true
  name_regex  = "^${var.configs.ami_prefix}-[0-9]{14}$"

  filter {
    name   = "name"
    values = ["${var.configs.ami_prefix}-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}