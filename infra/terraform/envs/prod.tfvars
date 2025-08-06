variable "region" {
  type = string

  default = "us-east-1"

  description = "AWS region"
}

variable "instance" {
  type = object({
    region = string

    count = number

    type = string 
    })
  }

  default = {
    count = 2

      region = "us-east-1"

      type = "t3.micro"
}

variable "vpc_cidr_block" {
  type = string

  default = "10.0.0.0/16"
  }

variable "public_subnets" {
  type = list(string)

  default = [
    "10.0.1.0/24",
  ]
}

variable "private_subnets" {
  type = list(string)

  default = [
    "10.0.2.0/24",
  ]
}

variable "availability_zones" {
  type = list(string)

  default = [
    "us-east-1a",
  ]
}