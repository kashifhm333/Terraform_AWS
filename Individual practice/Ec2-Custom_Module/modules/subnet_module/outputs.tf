output "aws_subnet_id" {
  description = "The ID of the created Subnet"
  value       = aws_subnet.my_subnet.id
}
