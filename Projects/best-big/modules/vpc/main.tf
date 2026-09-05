resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = var.vpc_tags
  enable_dns_hostnames = true   
  enable_dns_support = true
}


resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags ={
        name = "my-igw"
    }
}


resource "aws_subnet" "public_subnet" {
    count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block[count.index]
  availability_zone = data.aws_availability_zones.avaliable.names[count.index]
  map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-${count.index + 1}"
    }
}


resource "aws_subnet" "private_app" {
    count = 2 
    cidr_block = var.private_app_cidr_block[count.index]
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = data.aws_availability_zones.avaliable.names[count.index]
    tags = {
        Name = "private-app-subnet-${count.index + 1}"
}
}

resource "aws_subnet" "privat_data" {
    count = 2
    cidr_block = var.private_data_cidr_block[count.index]
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = data.aws_availability_zones.avaliable.names[count.index]
    tags = {
        Name = "private-data-subnet-${count.index + 1}"
    }
  
}



resource "aws_eip" "my_eip" {
    count = 2
    tags = {
      Name: "my_eip-${count.index + 1}"
    }
  
}



resource "aws_nat_gateway" "my_ngw" {
    count = 2
    allocation_id = aws_eip.my_eip[count.index].id
    subnet_id = aws_subnet.public_subnet[count.index].id
    tags = {
        Name = "my-nat-gateway-${count.index + 1}"
    }
  
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = aws_eip.my_eip[count.index].tags

}


resource "aws_route_table_association" "public_rt_assoc" {
  count = 2
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table" "private" {
     count = 2
    vpc_id = aws_vpc.my_vpc.id

    route {
       
        cidr_block = "0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my_ngw[count.index].id
    }
    tags = aws_eip.my_eip[count.index].tags
  
}

resource "aws_route_table_association" "private_rt_assoc" {
    count = 2
    subnet_id = aws.subnet.private_app[count.index].id
    route_table_id = aws_route_table.private[count.index].id
  
}


