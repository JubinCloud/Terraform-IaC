provider "aws" { region = var.region }

resource "aws_iam_role" "lambda_role" {
  name = "${var.name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}
data "aws_iam_policy_document" "assume_lambda" {
  statement { actions = ["sts:AssumeRole"]; principals { type="Service"; identifiers=["lambda.amazonaws.com"] } }
}
resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}
data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = ["s3:GetObject","s3:PutObject","s3:ListBucket"]
    resources = ["arn:aws:s3:::*"]
  }
  statement { actions = ["logs:CreateLogGroup","logs:CreateLogStream","logs:PutLogEvents"]; resources = ["*"] }
}

resource "aws_lambda_function" "zipper" {
  function_name = "${var.name}-zipper"
  filename      = "${path.module}/../lambda/zipper.zip" # create zip prior or use archive_file
  handler       = "handler.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = 512
  timeout       = 60
}

resource "aws_apigatewayv2_api" "http_api" {
  name = "${var.name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.zipper.arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "route" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /zip"
  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.zipper.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.http_api.id
  name   = "$default"
  auto_deploy = true
}
