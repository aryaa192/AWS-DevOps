terraform {
  required_providers {
     aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
     }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "app_server" {
    instance_type = "t2.micro"
    ami = "ami-068257025f72f470d"
    vpc_security_group_ids = "sg-0298c69eabfacc8c8"
    subnet_id = "subnet-0fe2b30644bfd18a7"
}
