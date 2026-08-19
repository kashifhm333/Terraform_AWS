resource "aws_instance" "exmaple" {
  ami = "ami-024f768332f0" #ami for the localstack
  count = var.instance_count
  instance_type = var.environment == "dev" ? "t2.micro" : "t2.small"
  tags = var.tags
}

resource "aws_security_group" "ingres" {
  name = "sg"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content{
    from_port = ingress.value.form_port
    to_port = ingress.value.to_port
    cidr_blocks = ingress.value.cidr_blocks
    protocol = ingress.value.protocol
    }
  }
}