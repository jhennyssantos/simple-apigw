variable "environment" {
  default = "staging"

}

variable "request_model" {
  default = "Empty"
}

variable "integration_error_template" {
  default = <<EOF
#set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')) {
  "message" : "$errorMessageObj.message"
}
EOF
}