resource "aws_api_gateway_rest_api" "notes_api" {
  name        = "Notes API"
  description = "API for Folder and Notes Services"
}

module "folder" {
  source      = "./modules/api_gateway"
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "folder"
  methods = [
    {
      http_method     = "PUT"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    },
    {
      http_method     = "DELETE"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    },
    {
      http_method     = "GET"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    },
    {
      http_method     = "POST"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    }
  ]
}

module "folder_id" {
  source      = "./modules/api_gateway"
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = module.folder.aws_api_gateway_resource.this.id
  path_part   = "{folderId}"
  methods = [
    {
      http_method     = "PUT"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    },
    {
      http_method     = "DELETE"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.folder_service.invoke_arn
    }
  ]
}

module "note" {
  source      = "./modules/api_gateway"
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "note"
  methods = [
    {
      http_method     = "POST"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.note_service.invoke_arn
    },
    {
      http_method     = "DELETE"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.note_service.invoke_arn
    }
  ]
}

module "note_id" {
  source      = "./modules/api_gateway"
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = module.note.aws_api_gateway_resource.this.id
  path_part   = "{noteId}"
  methods = [
    {
      http_method     = "GET"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.notes_service.invoke_arn
    },
    {
      http_method     = "PUT"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.notes_service.invoke_arn
    }
  ]
}

module "note_list" {
  source      = "./modules/api_gateway"
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = module.note.aws_api_gateway_resource.this.id
  path_part   = "list"
  methods = [
    {
      http_method     = "GET"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.notes_service.invoke_arn
    }
  ]
}

output "api_endpoint" {
  value = aws_api_gateway_rest_api.notes_api.execution_arn
}
