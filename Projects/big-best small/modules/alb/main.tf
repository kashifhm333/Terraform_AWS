resource "aws_security_group" "alb_sg" {
    name = "my_security_group"
    vpc_id = aws_vpc.my_vpc.id
    description = "allow the http inboound traffic"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "app_sg" {
    name = "app_security_group"
    vpc_id = aws_vpc.my_vpc.id
    description = "allow traffic from alb only"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    egress {
    from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_security_group" "dg_sg" {
    name = "dg_security_group"
    vpc_id = aws_vpc.my_vpc.id
    description = "allow postgresSQL traffic from app tier"
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.app_sg.id]
    }
  
    egress {
    from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
