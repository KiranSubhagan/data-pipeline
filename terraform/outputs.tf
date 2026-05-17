output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "lambda_name" {
  value = aws_lambda_function.processor.function_name
}
