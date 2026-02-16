output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "Public DNS name of the Application Load Balancer"
}

output "app_tg_arn" {
  value       = aws_lb_target_group.app_tg.arn
  description = "Target group ARN for the app tier"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.app.name
}