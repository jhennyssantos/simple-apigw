resource "aws_api_gateway_rest_api" "simple_apigw" {
  name = "simple_apigw"
}

resource "aws_api_gateway_resource" "bucket_resource" {
  parent_id   = aws_api_gateway_rest_api.simple_apigw.root_resource_id
  path_part   = "bucket"
  rest_api_id = aws_api_gateway_rest_api.simple_apigw.id
}

resource "aws_api_gateway_resource" "bucket_item_resource" {
  parent_id   = aws_api_gateway_resource.bucket_resource.id
  path_part   = "{item}"
  rest_api_id = aws_api_gateway_rest_api.simple_apigw.id
}

resource "aws_api_gateway_method" "item_method" {
  rest_api_id   = aws_api_gateway_rest_api.simple_apigw.id
  resource_id   = aws_api_gateway_resource.bucket_item_resource.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_integration" "item_integration" {
  rest_api_id             = aws_api_gateway_rest_api.simple_apigw.id
  resource_id             = aws_api_gateway_resource.bucket_item_resource.id
  http_method             = aws_api_gateway_method.item_method.http_method
  integration_http_method = "PUT"
  type                    = "AWS"
  credentials             = aws_iam_role.simple_apigw_role.arn
  uri                     = "arn:aws:apigateway:us-east-1:s3:path/${aws_s3_bucket.simple_apigw_s3.bucket}/bucket/{item}"
}

resource "aws_api_gateway_method_response" "item_response_200" {
  rest_api_id = aws_api_gateway_rest_api.simple_apigw.id
  resource_id = aws_api_gateway_resource.bucket_item_resource.id
  http_method = aws_api_gateway_method.item_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = var.request_model
  }
  #response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}

resource "aws_api_gateway_integration_response" "item_Integration400" {
  rest_api_id = aws_api_gateway_rest_api.simple_apigw.id
  resource_id = aws_api_gateway_resource.bucket_item_resource.id
  http_method = aws_api_gateway_method.item_method.http_method
  status_code = aws_api_gateway_method_response.item_response_200.status_code
  response_templates = {
    "application/json" = var.integration_error_template
  }
  #response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}


