output "account_id" {
  description = "The ID of this account."
  value       = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  description = "ARN of the calling identity."
  value       = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  description = "Username of the calling identity."
  value       = "${data.aws_caller_identity.current.user_id}"
}
