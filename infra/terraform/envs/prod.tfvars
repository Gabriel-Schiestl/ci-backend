region = "us-east-1"

instance = {
  region = "us-east-1"
  count  = 2
  type   = "t3.micro"
}

vpc_cidr_block = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
]

private_subnets = [
  "10.0.2.0/24",
]

availability_zones = [
  "us-east-1a",
]