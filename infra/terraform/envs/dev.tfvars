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
    count = 1

      region = "us-east-1"

      type = "t2.micro"
}

variable "vpc_cidr_block" {
  type = string

  default = "172.16.0.0/16"
  }

variable "public_subnets" {
  type = list(string)

  default = [
    "172.16.1.0/24",
  ]
}

variable "private_subnets" {
  type = list(string)

  default = [
    "172.16.2.0/24",
  ]
}

variable "availability_zones" {
  type = list(string)

  default = [
    "us-east-1a",
  ]
}
