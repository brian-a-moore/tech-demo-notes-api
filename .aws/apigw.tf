locals {
  resources = {
    folder = "/folder"
    note   = "/note"
  }

  folder_methods = {
    create = {
      method = "POST"
      path   = "/"
    }
    update = {
      method = "PUT"
      path   = "/{folderId}"
    }
    list = {
      method = "GET"
      path   = "/"
    }
    get = {
      method = "GET"
      path   = "/{folderId}"
    }
    delete = {
      method = "DELETE"
      path   = "/{folderId}"
    }
  }

  note_methods = {
    create = {
      method = "POST"
      path   = "/"
    }
    update = {
      method = "PUT"
      path   = "/{noteId}"
    }
    get = {
      method = "GET"
      path   = "/{noteId}"
    }
    delete = {
      method = "DELETE"
      path   = "/{noteId}"
    }
  }
}

resource "aws_api_gateway_rest_api" "notes_api" {
  name        = "notes_api"
  description = "API for Notes Application"
}

resource "aws_api_gateway_resource" "resources" {
  for_each = local.resources

  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = trim(each.value, "/")

  depends_on = [aws_lambda_function.notes_api]
}

resource "aws_api_gateway_method" "folder_methods" {
  for_each = local.folder_methods

  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.resources["folder"].id
  http_method   = each.value.method
  authorization = "NONE"

  lifecycle {
    ignore_changes = [http_method]
  }

  depends_on = [aws_api_gateway_resource.resources]
}

resource "aws_api_gateway_method" "note_methods" {
  for_each = local.note_methods

  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.resources["note"].id
  http_method   = each.value.method
  authorization = "NONE"

  lifecycle {
    ignore_changes = [http_method]
  }

  depends_on = [aws_api_gateway_resource.resources]
}

resource "aws_api_gateway_integration" "folder_integrations" {
  for_each = local.folder_methods

  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.resources["folder"].id
  http_method             = each.value.method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn

  depends_on = [aws_api_gateway_method.folder_methods]
}

resource "aws_api_gateway_integration" "note_integrations" {
  for_each = local.note_methods

  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.resources["note"].id
  http_method             = each.value.method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn

  depends_on = [aws_api_gateway_method.note_methods]
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id

  triggers = {
    redeploy = "${timestamp()}"
  }

  depends_on = [
    aws_lambda_function.notes_api,
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
