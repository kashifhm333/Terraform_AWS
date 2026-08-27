resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    env = "demo"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    "igw" = "demo"
  }

}

resource "aws_subnet" "public_Subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    "public-subnet" = "demo"
  }
}


resource "aws_subnet" "private_subnet_ec2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "private-subnet-ec2" = "demo"
  }
}


resource "aws_subnet" "private_subnet_db" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "private-subnet-db" = "demo"
  }

}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.igw ]

}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_Subnet.id

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.public_Subnet.id
  route_table_id = aws_route_table.public_rt.id


}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_rt_db" {
  subnet_id      = aws_subnet.private_subnet_db.id
  route_table_id = aws_route_table.private_rt.id
  
}

resource "aws_route_table_association" "private_rt_ec2" {
    subnet_id = aws_subnet.private_subnet_ec2.id
    route_table_id = aws_route_table.private_rt.id
  
}

resource "aws_security_group" "public_sg_ec2" {
  name = "all_inbound_ssh"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "private_sg_ec2" {
    name = "private_sg_ec2"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        description = "Allow SSH from public ec2"
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        security_groups = [aws_security_group.public_sg_ec2.id]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_security_group" "private_sg_db" {
  vpc_id = aws_vpc.my_vpc.id
  name = "private_sg_db"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    security_groups = [aws_security_group.private_sg_ec2.id]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


resource "aws_instance" "public_ec2" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_Subnet.id
    vpc_security_group_ids = [aws_security_group.public_sg_ec2.id]
    tags = {
    Name = "Public-Bastion-EC2"
  }
}

resource "aws_instance" "private_ec2" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet_ec2.id
    vpc_security_group_ids = [aws_security_group.private_sg_ec2.id]
    tags = {
    Name = "Private-EC2"
  }
  
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_db.id, aws_subnet.private_subnet_ec2.id]

  tags = {
    Name = "DB Subnet Group"
  }
  
}


resource "aws_db_instance" "db" {
  allocated_storage      = 20
  db_name                = "appdb"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  username               = "dbadmin"
  password               = "ChangeMeStrongPass123!" # Use AWS Secrets Manager for production
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.private_sg_db.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "Private-Postgres-DB"
  }
}