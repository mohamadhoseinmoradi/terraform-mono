output "user_1_arn" {
  value       = aws_iam_user.users[0].arn
  description = "The ARN for user_1"
}

output "all_arns" {
  value       = [for user in aws_iam_user.users : user.arn]
  description = "The ARNs for all users"
}
