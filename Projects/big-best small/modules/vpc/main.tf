resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
 enable_dns_hostnames = true
 enable_dns_support = true
  tags = var.vpc_tags
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
  
}

resource "aws_subnet" "public" {
    count = 1
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnets_cidr_block[0]
    availability_zone = data.aws_availability_zone.available.name[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet_${count.index + 1}"
    }
}

resource "aws_subnet" "Private" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnets_cidr_block[1]
  availability_zone = data.aws_availability_zone.available.name[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "Private_data" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnets_cidr_block[2]
  availability_zone = data.aws_availability_zone.available.name[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_2"
  }
  
}


resource "aws_eip" "my_eip" {
  domain = "vpc"
  }

resource "aws_nat_gateway" "my_ngw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id = aws_subnet.public.id
  
}

resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    gateway_id = aws_internet_gateway.my_igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "my_public_rt_assoc" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.my_public_rt.id
  
}

resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    nat_gateway_id = aws_nat_gateway.my_ngw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "my_private_rt_assoc" {
  subnet_id = aws_subnet.Private.id
  route_table_id = aws_route_table.my_private_rt.id
  
}



