variable "region" {
  type = string

  description = "AWS region"
}

variable "instance" {
  type = object({
    region = string

    count = number

    type = string 
    })
  }

  variable "vpc_cidr_block" {
  type = string

  }

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)

}

variable "availability_zones" {
  type = list(string)

}
