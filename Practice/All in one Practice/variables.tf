variable "bucket_name" {
    type = list(string)
    default = [ "bucket_1" , "bucket_2" , "bucket_3" ]
  
}


variable "tags" {
  type = object({
    Env = string
    Name = string
  })
  default = {
    Env = "Demo"
    Name = "Car"
  }
}