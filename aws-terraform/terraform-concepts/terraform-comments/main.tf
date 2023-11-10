terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm1" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "jenkins-key"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

resource "aws_instance" "vm2" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "jenkins-key"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name      = "my-unique-bucket-${random_string.bucket_suffix.result}"
    Create_By = "Terraform"
  }
}