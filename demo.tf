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
resource "aws_security_group" "example_security_group" {
  name        = "example-security-group"
  description = "Example Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 


resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2_ssm_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  role       = aws_iam_role.ec2_ssm_role.name
}

resource "aws_s3_bucket" "amda" {
  bucket = "my-tf-test-bucket876713"
  tags = {
    Name = "My bucket"
    Environment = "Test"
  }
}
