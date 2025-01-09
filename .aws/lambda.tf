resource "aws_lambda_function" "notes_api" {
  function_name    = "folder_service"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  filename         = "${path.module}/../.serverless/notes-api.zip"
  source_code_hash = filebase64sha256("${path.module}/../.serverless/notes-api.zip")
  runtime          = "nodejs18.x"
  timeout          = 10

  environment {
    variables = {
      DB_NAME = aws_dynamodb_table.notes_api_database.name
    }
  }
}

resource "aws_lambda_permission" "apigw_notes_api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes_api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.notes_api.execution_arn}/*/*/{proxy+}"
}


resource "aws_cloudwatch_log_group" "notes_api_log_group" {
  name              = "/aws/lambda/notes_api"
  retention_in_days = 14
}

