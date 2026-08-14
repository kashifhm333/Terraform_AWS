resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block[2]
  tags       = var.tags

}
# resource "aws_instance" "instance" {
#   # count = var.instance_count
#   ami           = "ami-024f768332f0" # LocalStack's built-in Amazon Linux 2023 AMI
#   instance_type = var.config.instance_type

#   depends_on = [ aws_vpc.myvpc ]
#   lifecycle {
#     create_before_destroy = true
#   }
#    tags = var.tags

# }

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
  tags   = var.tags
  # lifecycle {
  #   create_before_destroy = true
  # }
  
}