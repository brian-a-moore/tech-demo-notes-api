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

resource "aws_api_gateway_integration" "this" {
  for_each                = { for method in var.methods : method.http_method => method }
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = each.value.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = each.value.integration_uri
}
