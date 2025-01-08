resource "aws_lambda_function" "folder_service" {
  function_name    = "folder_service"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  filename         = "./.serverless/folder_service.zip"
  source_code_hash = filebase64sha256("./.serverless/folder_service.zip")
  runtime          = "nodejs18.x"
  timeout          = 10

  environment {
    variables = {
      DB_NAME = aws_dynamodb_table.notes_api_database.name
    }
  }
}

resource "aws_lambda_function" "notes_service" {
  function_name    = "notes_service"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  filename         = "./.serverless/note_service.zip"
  source_code_hash = filebase64sha256("./.serverless/note_service.zip")
  runtime          = "nodejs18.x"
  timeout          = 10

  environment {
    variables = {
      DB_NAME = aws_dynamodb_table.notes_api_database.name
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.folder_service.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.notes_api.execution_arn}/*/*/{proxy+}"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes_service.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.notes_api.execution_arn}/*/*/{proxy+}"
}
