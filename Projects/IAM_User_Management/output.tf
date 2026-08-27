# output "caller" {
#     value = data.aws_caller_identity.name
# }


output "details" {
 value =  [for user in local.users: "${user.first_name} ${user.last_name}"]
}


output "user_password" {
  value = {
    for user,profile in aws_iam_user_login_profile.user:
    user => "password created - usr must rest on first login"
  }
}