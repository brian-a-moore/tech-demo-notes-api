resource "aws_api_gateway_rest_api" "notes_api" {
  name        = "notes_api"
  description = "API for Notes Application"
}

resource "aws_api_gateway_resource" "folder_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "folder"
}

resource "aws_api_gateway_resource" "note_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "note"
}

resource "aws_api_gateway_resource" "folder_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_resource.folder_resource.id
  path_part   = "{folderId}"
}

resource "aws_api_gateway_resource" "note_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_resource.note_resource.id
  path_part   = "{noteId}"
}

resource "aws_api_gateway_method" "create_folder_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.folder_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "list_folder_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.folder_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "delete_folder_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.folder_id_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_folder_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.folder_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "update_folder_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.folder_id_resource.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "create_note_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.note_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "delete_note_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.note_id_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_note_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.note_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "update_note_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.note_id_resource.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "create_folder_itegration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "create_folder_itegration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "list_folder_itegration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_resource.id
  http_method             = "GET"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "delete_folder_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_id_resource.id
  http_method             = "DELETE"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "get_folder_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_id_resource.id
  http_method             = "GET"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "update_folder_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.folder_id_resource.id
  http_method             = "PUT"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "create_note_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.note_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "delete_note_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.note_id_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "get_note_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.note_id_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "update_note_integration" {
  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.note_id_resource.id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id

  triggers = {
    redeploy = "${timestamp()}"
  }

  depends_on = [
    aws_api_gateway_method.folder_methods,
    aws_api_gateway_method.note_methods,
    aws_api_gateway_integration.folder_integrations,
    aws_api_gateway_integration.note_integrations
  ]
}

resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
