resource "aws_s3_bucket" "simple_apigw_s3" {
  bucket = "simple-apigw-photocollection-s3"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = var.environment
  }
}