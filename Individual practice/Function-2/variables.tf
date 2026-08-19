variable "project_name" {
  description = "The name of the project."
  type        = string
  default = "web based project"
  
}


variable "default_tags" {
  type = map(string)
  default = {
    name        = "MyProject"
  }
  
}

variable "enviroment_tags" {
  type = map(string)
  default = {
    env         = "dev"
  }
}

variable "bucket_name" {
  type = string
  default = "this is The buckeT name I have ChoOsen"
  
}


variable "ports" {
  type = string
  default = "80,443,3000" 
}


variable "instance_type" {
  type = string
  default = "t2.micro"

  validation {
    condition = length(var.instance_type) >=2 && length(var.instance_type) <=20
    error_message = "I dont not follow"
  }

  validation {
    condition = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "Instance type must be a valid t2 or t3 instance type"
  }


}




variable "backup_name" {
  type = string
  default = "daily_backup"
  validation {
    condition = endswith(var.backup_name, "_backup")
    error_message = "it must be ends with _backup"
  }
}

variable credentials {
  default = "Ronaldo"
  sensitive = true
}

variable "user_locations" {
  type = list(string)
  default = [ "us-east-1", "us-west-2", "us-east-1" ]
  
}



variable "default_locations" {
  type = list(string)
  default = [ "us-west-1"]
  
}

variable "monthly_cost" {
  default = [-50,100,75,200]
}