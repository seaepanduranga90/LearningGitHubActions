terraform {
  backend "s3" {
    bucket = "terraformbucket12344"
    key = "terraformbucket12344/terraform.tfstate"
    region = "ap-south-1"
    workspace_key_prefix = "Test"
  }
}
