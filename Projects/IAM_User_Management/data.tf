data "aws_caller_identity" "username" {}

output "caller" {
    value = data.aws_caller_identity.username
}