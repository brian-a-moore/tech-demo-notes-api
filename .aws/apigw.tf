variable "rest_api_id" {}
variable "parent_id" {}
variable "path_part" {}
variable "methods" {
  type = list(object({
    http_method     = string
    authorization   = string
    integration_uri = string
  }))
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = var.path_part
}

resource "aws_api_gateway_method" "this" {
  for_each      = { for method in var.methods : method.http_method => method }
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = each.value.http_method
  authorization = each.value.authorization
}

resource "aws_api_gateway_integration" "this" {
  for_each                = { for method in var.methods : method.http_method => method }
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = each.value.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = each.value.integration_uri
}

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
      integration_uri = aws_lambda_function.note_get.invoke_arn
    },
    {
      http_method     = "PUT"
      authorization   = "NONE"
      integration_uri = aws_lambda_function.note_put.invoke_arn
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
      integration_uri = aws_lambda_function.note_list.invoke_arn
    }
  ]
}

output "api_endpoint" {
  value = aws_api_gateway_rest_api.notes_api.execution_arn
}
