resource "aws_vpc" "Myvpc" {
    cidr_block = "10.0.0.0/24"
      tags = var.tags

}
resource "aws_subnet" "MySubnet" {
  vpc_id     = aws_vpc.Myvpc.id
  cidr_block = "10.0.0.0/26"
  tags = var.tags
}


resource "aws_instance" "instance" {
  # count = var.instance_count
  count = var.config.count
  ami           = "ami-024f768332f0" # LocalStack's built-in Amazon Linux 2023 AMI
  instance_type = var.config.instance_type
  subnet_id     = aws_subnet.MySubnet.id

  # monitoring = var.monitering_enable 
  # associate_public_ip_address = var.associate_public_ip_address

   tags = var.tags

}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[0]
  from_port         = var.ingress_rules[0]
  ip_protocol       = var.ingress_rules[1]
  to_port           = var.ingress_rules[2]
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

