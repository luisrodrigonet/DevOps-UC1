terraform {
  backend "s3" {
    bucket                      = "meu-terraform-state"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    endpoints = {
      s3 = "http://127.0.0.1:4566"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
    skip_requesting_account_id  = true
  }
}
