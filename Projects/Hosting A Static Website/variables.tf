variable "bucket_name" {
  type = string
  default = "test_bucket"
}


variable "tags" {
  type = object({
    env = string
  })
  default = {
    env = "demo"
  }
}