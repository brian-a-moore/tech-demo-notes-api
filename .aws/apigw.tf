resource "aws_api_gateway_rest_api" "notes_api" {
  name        = "notes-api"
  description = "API for Notes Application"
}

resource "aws_api_gateway_resource" "proxy_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.proxy_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy_integration" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  resource_id = aws_api_gateway_resource.proxy_resource.id
  http_method = aws_api_gateway_method.proxy_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.oriter_api.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  stage_name  = "v1"

  depends_on = [
    aws_api_gateway_integration.proxy_integration
  ]
}

locals {
  api_endpoints = {
    folder-create = {
      method          = "POST"
      path            = "/folder"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:folder_service"
    }
    folder-update = {
      method          = "PUT"
      path            = "/folder/{folderId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:folder_service"
    }
    folder-list = {
      method          = "GET"
      path            = "/folder"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:folder_service"
    }
    folder-get = {
      method          = "GET"
      path            = "/folder/{folderId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:folder_service"
    }
    folder-delete = {
      method          = "DELETE"
      path            = "/folder/{folderId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:folder_service"
    }
    note-create = {
      method          = "POST"
      path            = "/note"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:note_service"
    }
    note-update = {
      method          = "PUT"
      path            = "/note/{noteId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:note_service"
    }
    note-get = {
      method          = "GET"
      path            = "/note/{noteId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:note_service"
    }
    note-delete = {
      method          = "DELETE"
      path            = "/note/{noteId}"
      integration_uri = "arn:aws:lambda:us-east-1:339713013981:function:note_service"
    }
  }
}

resource "aws_api_gateway_resource" "api_resources" {
  for_each    = local.api_endpoints
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = each.value.path
}

resource "aws_api_gateway_method" "api_methods" {
  for_each      = local.api_endpoints
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resources[each.key].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integrations" {
  for_each    = local.api_endpoints
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  resource_id = aws_api_gateway_resource.api_resources[each.key].id
  http_method = aws_api_gateway_method.api_methods[each.key].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = each.value.integration_uri
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id

  depends_on = [
    aws_api_gateway_integration.api_integrations
  ]
}

resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}
