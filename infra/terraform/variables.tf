variable "region" {
  type = string

  default = "us-east-1"

  description = "AWS region"
}

variable "profile" {
  type = string

  default = "tf01"
}

variable "environment" {
  type = string

  description = "Environment to separate production and development"
}

variable "instance" {
  type = object({
    dev = object({
      region = string

      count = number

      type = string
    })

    prod = object({
      region = string

      count = number

      type = string
    })
  })

  default = {
    dev = {
      count = 1

      region = "us-east-1"

      type = "t2.micro"
    }

    prod = {
      count = 2

      region = "us-east-1"

      type = "t3.micro"
    }
  }
}
