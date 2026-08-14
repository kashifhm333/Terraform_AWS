locals {
  formatted_project_name = lower(var.project_name)
  new_tags =merge(var.default_tags, var.enviroment_tags)

  bucket_name = lower(substr(replace(var.bucket_name," ", "-"), 0, 63))

  ports_list = split(",", var.ports)

  sg_rule = [for port in local.ports_list :{
    name = "port-${port}"
    port = port
  }]



  all_locations = concat(var.user_locations,var.default_locations)
  set_locations = toset((local.all_locations))



  positive_cost = [for cost in var.monthly_cost : abs(cost)]
  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
  total_cost = sum(local.positive_cost)
  average_cost = local.total_cost / length(local.positive_cost)



  config_file_exists = fileexists("./config.json")
  config_data = try(jsondecode(file("${path.module}/config.json")), {})
}


resource "aws_s3_bucket" "mybucket" {
  bucket = local.bucket_name
  tags = local.new_tags
}


