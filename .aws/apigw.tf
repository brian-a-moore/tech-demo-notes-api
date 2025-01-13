locals {
  resources = {
    folder = "folder"
    note   = "note"
  }

  folder_methods = {
    create_folder = {
      method = "POST"
      path   = "/"
    }
    update_folder = {
      method = "PUT"
      path   = "/{folderId}"
    }
    list_folder = {
      method = "GET"
      path   = "/"
    }
    get_folder = {
      method = "GET"
      path   = "/{folderId}"
    }
    delete_folder = {
      method = "DELETE"
      path   = "/{folderId}"
    }
  }

  note_methods = {
    create_note = {
      method = "POST"
      path   = "/"
    }
    update_note = {
      method = "PUT"
      path   = "/{noteId}"
    }
    get_note = {
      method = "GET"
      path   = "/{noteId}"
    }
    delete_note = {
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
  path_part   = each.value
}

resource "aws_api_gateway_method" "folder_methods" {
  for_each = local.folder_methods

  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.resources["folder"].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_method" "note_methods" {
  for_each = local.note_methods

  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.resources["note"].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "folder_integrations" {
  for_each = local.folder_methods

  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.resources["folder"].id
  http_method             = each.value.method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.notes_api.invoke_arn
}

resource "aws_api_gateway_integration" "note_integrations" {
  for_each = local.note_methods

  rest_api_id             = aws_api_gateway_rest_api.notes_api.id
  resource_id             = aws_api_gateway_resource.resources["note"].id
  http_method             = each.value.method
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
