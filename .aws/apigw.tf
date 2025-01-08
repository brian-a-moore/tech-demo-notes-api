variable "api_endpoints" {
  type = map(object({
    method          = string
    path            = string
    integration_uri = string
  }))
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
  integration_uri    = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${each.value.integration_uri}/invocations"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "routes" {
  for_each = var.api_endpoints

  api_id    = aws_apigatewayv2_api.notes_api.id
  route_key = "${each.value.method} ${each.value.path}"
  target    = "integrations/${aws_apigatewayv2_integration.integrations[each.key].id}"
}

resource "aws_apigatewayv2_deployment" "deployment" {
  depends_on = [aws_apigatewayv2_route.routes]
  api_id     = aws_apigatewayv2_api.notes_api.id
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.notes_api.id
  name        = "prod"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_log_group.arn
    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }

  default_route_settings {
    logging_level            = "INFO"
    data_trace_enabled       = true
    detailed_metrics_enabled = true
  }
}

resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name              = "/aws/apigateway/notes_api"
  retention_in_days = 14
}

output "api_url" {
  value = aws_apigatewayv2_stage.stage.invoke_url
}

