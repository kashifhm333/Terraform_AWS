resource "aws_s3_bucket" "bucket1" {
  count = length(var.s3_buckets)
  bucket = var.s3_buckets[count.index]


  tags = var.tags
}


resource "aws_s3_bucket" "set_bucket" {
  for_each = var.s3_buckets_set
  bucket = each.value

  tags = var.tags

  depends_on = [ aws_s3_bucket.bucket1]
}