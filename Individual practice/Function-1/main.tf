locals {
  formatted_project_name = lower(var.project_name)
  new_tags =merge(var.default_tags, var.enviroment_tags)

  bucket_name = lower(substr(replace(var.bucket_name," ", "-"), 0, 63))

  ports_list = split(",", var.ports)

  sg_rule = [for port in local.ports_list :{
    name = "port-${port}"
    port = port
  }]

}


resource "aws_s3_bucket" "mybucket" {
  bucket = local.bucket_name
  tags = local.new_tags
}