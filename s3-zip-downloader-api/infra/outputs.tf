output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.zipper.function_name
}

output "api_endpoint" {
  description = "HTTP API endpoint URL"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}
