terraform {
  required_version = ">= 1.0.0"
  required_providers { 
    
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile    = "default" 
  region     = "us-east-1"
}


resource "aws_instance" "example" {
  ami                    = "ami-079db87dc4c10ac91"
  instance_type          = "t2.micro"
  key_name               = "Key-pair-cas"
  vpc_security_group_ids = ["sg-04ddd59286c754bfb"]
  subnet_id              = "subnet-0004e2bc6eb9b6f4b"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name      = "cas-vm"
    Create_By = "Terraform"
  }
}


