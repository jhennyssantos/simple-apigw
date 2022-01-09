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
}

resource "aws_api_gateway_integration" "item_integration" {
  rest_api_id             = aws_api_gateway_rest_api.simple_apigw.id
  resource_id             = aws_api_gateway_resource.bucket_item_resource.id
  http_method             = aws_api_gateway_method.item_method.http_method
  integration_http_method = "PUT"
  type                    = "AWS"
  credentials             = aws_iam_role.simple_apigw_role.arn
  uri                     = "arn:aws:apigateway:us-east-1:s3:path/${aws_s3_bucket.simple_apigw_s3.bucket}/{item}"
}



