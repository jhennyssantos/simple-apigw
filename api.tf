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




