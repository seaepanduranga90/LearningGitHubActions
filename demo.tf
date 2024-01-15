terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>4.16"
    }
  }
  required_version = "1.0.0" 
}

provider "aws" {
  access_key = "AKIA6HZQMFAYXVEZILSG"
  secret_key = "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"
  region = "ap-south-1"  
}

resource "aws_instance" "demo" {
  ami = var.ami_id
  instance_type = var.instance_type["ap-south-1"]
  #security_groups = var.security_group
  #availability_zone = var.availability_zone[2]
}
variable "ami_id" {
  
}
variable "availability_zone" {
  type = list
  default = ["us-east-1","us-west-1","ap-south-1","us-east-2"]
}
variable "instance_type" {
  type = map
  default = {
    us-east-1 = "t2.micro"
    us-west-1 = "t2.large"
    us-east-2 = "t2.small"
    ap-south-1 = "t2.micro"
  }
}
#provider "awsr" {
 # region = "us-west-2"
#}
#resource "aws_s3_bucket" "amda" {
 # bucket = "my-tf-test-bucket876713"
  #tags = {
   # Name = "My bucket"
    #Environment = "Test"
  #}
#}
