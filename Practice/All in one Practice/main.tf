locals {
#   bucket_name = "${var.bucket_name[count.index]}-${timestamp()}-kashif"
  time = lower(formatdate("YYYY-MM-DD", timestamp()))
}

resource "aws_s3_bucket" "example" {
  count = length(var.bucket_name)
  bucket = lower("${var.bucket_name[count.index]}-${local.time}-kashif")
  tags = var.tags
}