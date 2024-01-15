terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket876713"
    key = "my-tf-test-bucket876713/terraform.tfstate"
    region = "ap-south-1"
    workspace_key_prefix = "Test"
  }
}