resource "aws_key_pair" "kp" {
  key_name   = "kp_${var.configs.name}"
  public_key = file(var.configs.public_key_path)
    # public_key = file("${path.root}/lab-kp.pub")
}

resource "aws_security_group" "sg" {
  name        = "sg_${var.configs.name}"
  vpc_id = var.configs.vpc_id

  dynamic "ingress" {
    for_each = var.configs.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami             = data.aws_ami.latest_ami.id
  instance_type   = var.configs.instance_type
  key_name        = aws_key_pair.lab_key.key_name
  security_groups = [aws_security_group.sg.name]
  subnet_id = var.configs.subnet_id
  tags = try(var.configs.tags, {})
}