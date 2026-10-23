output "role_arn" {
  description = "Goes into the ServiceAccount annotation eks.amazonaws.com/role-arn"
  value       = aws_iam_role.app.arn
}
