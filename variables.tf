variable "environment" {
  default = "staging"

}

variable "request_model" {
  default = "Empty"
}

variable "integration_sucess_template" {
  default = <<EOF
{
  "message" : "Arquivo enviado com sucesso!"
}
EOF
}

variable "integration_sucess_delete" {
  default = <<EOF
{
  "message" : "Arquivo DELETADO com sucesso!"
}
EOF
}