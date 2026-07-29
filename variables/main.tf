resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-test-bucket"
    
  tags = {
    Name        = "${var.environment}-bucket"
    Environment = var.environment
  }

}

resource "aws_vpc" "Myvpc" {
    cidr_block = "10.0.0.0/24"
    tags = {
     Name = "${var.environment}-VPC"
    Environment = var.environment
    }
}
resource "aws_subnet" "MySubnet" {
  vpc_id     = aws_vpc.Myvpc.id
  cidr_block = "10.0.0.0/26"
  tags = {
    Name = "${var.environment}-Subnet"
  }
}


resource "aws_instance" "instance" {
  ami           = "ami-024f768332f0" # LocalStack's built-in Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.MySubnet.id

  tags = {
    Name        = "${var.environment}-Instance"
    Environment = var.environment
  }
}

