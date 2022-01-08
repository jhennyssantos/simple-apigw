## POLICY
resource "aws_iam_policy" "simple_apigw_policy" {
  name        = "simple-apigw-photocollection"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.simple_apigw_s3.bucket}"
    }
  ]
}
EOF
}

## ROLE
resource "aws_iam_role" "simple_apigw_role" {
  name = "simple-apigw-photocollection-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}

## ATTACH POLICIES
resource "aws_iam_role_policy_attachment" "simple_apigw_attach" {
  role       = aws_iam_role.simple_apigw_role.name
  policy_arn = aws_iam_policy.simple_apigw_policy.arn
}