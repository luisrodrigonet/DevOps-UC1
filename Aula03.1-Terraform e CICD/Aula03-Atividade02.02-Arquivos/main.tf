provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"  # Credenciais fictícias
  secret_key                  = "test"  # Credenciais fictícias
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Configuração correta do endpoint para LocalStack
  endpoints {
    s3 = "http://127.0.0.1:4566"
  }
}



# Criação do bucket
resource "aws_s3_bucket" "meu_state_bucket" {
  bucket = "meu-terraform-state-unique"
}

# ACL separada para o bucket
resource "aws_s3_bucket_acl" "meu_state_bucket_acl" {
  bucket = aws_s3_bucket.meu_state_bucket.id
  acl    = "private"
}

# Referenciar o bucket
data "aws_s3_bucket" "state_bucket" {
  bucket = aws_s3_bucket.meu_state_bucket.bucket
}

output "bucket_name" {
  value = data.aws_s3_bucket.state_bucket.bucket
}


module "analyze-environment" {
  source = "./analyze-environment"  # Caminho para o módulo  
}

