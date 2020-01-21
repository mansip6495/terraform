variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "AMI" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-04b9e92b5572fa0d1" # ubuntu 14.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

