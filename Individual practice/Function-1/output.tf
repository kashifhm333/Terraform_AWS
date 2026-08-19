output "formatted_project_name" {
  value = lower(substr(replace(local.formatted_project_name, " ", "-"), 0, 255))
}


output "bucket_name" {
    value = local.bucket_name
  
}
    
output "ports_list" {
  value = local.ports_list[1]
}

output "sg_rules" {
    value = local.sg_rule
  
}