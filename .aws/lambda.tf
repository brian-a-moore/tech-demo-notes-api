resource "aws_lambda_function" "folder_service" {
  function_name    = "folder_service"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  filename         = "${path.module}/../.serverless/folderService.zip"
  source_code_hash = filebase64sha256("${path.module}/../.serverless/folderService.zip")
  runtime          = "nodejs18.x"
  timeout          = 10

  environment {
    variables = {
      DB_NAME = aws_dynamodb_table.notes_api_database.name
    }
  }
}

resource "aws_lambda_function" "note_service" {
  function_name    = "note_service"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  filename         = "${path.module}/../.serverless/noteService.zip"
  source_code_hash = filebase64sha256("${path.module}/../.serverless/noteService.zip")
  runtime          = "nodejs18.x"
  timeout          = 10

  environment {
    variables = {
      DB_NAME = aws_dynamodb_table.notes_api_database.name
    }
  }
}

resource "aws_lambda_permission" "apigw_folder_service" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.folder_service.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.notes_api.execution_arn}/*/*/{proxy+}"
}

resource "aws_lambda_permission" "apigw_note_service" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.note_service.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.notes_api.execution_arn}/*/*/{proxy+}"
}
