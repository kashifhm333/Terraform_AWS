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

output "crediantls" {
  value = var.credentials
  sensitive = true
}


output "locations" {
  value = local.all_locations
}


output "set_locations" {
  value = local.set_locations
}


output "positive_cost" {
  value = local.positive_cost
}


output "max_cost" {
  value = local.max_cost
  
}

output "min_cost" {
  value = local.min_cost
  
}


output "total_cost" {
  value = sum(local.positive_cost)
}

output "average_cost" {
 value = local.average_cost
}


output "json_file" {
  value = local.config_data
}