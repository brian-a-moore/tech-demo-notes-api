variable "api_endpoints" {
  type = map(object({
    method          = string
    path            = string
    integration_uri = string
  }))
  default = jsondecode(file("${path.module}/endpoints.json"))["endpoints"]
}

resource "aws_apigatewayv2_api" "notes_api" {
  name          = "Notes API"
  description   = "API for Folder and Notes Services"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "integrations" {
  for_each = var.api_endpoints

  api_id             = aws_apigatewayv2_api.notes_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = each.value.integration_uri
  integration_method = each.value.method
}

resource "aws_apigatewayv2_route" "routes" {
  for_each = var.api_endpoints

  api_id    = aws_apigatewayv2_api.notes_api.id
  route_key = "${each.value.method} ${each.value.path}"
  target    = "integrations/${aws_apigatewayv2_integration.integrations[each.key].id}"
}
