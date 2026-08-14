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