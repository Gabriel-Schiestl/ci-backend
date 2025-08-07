region = "us-east-1"

instance = {
  region = "us-east-1"
  count  = 1
  type   = "t2.micro"
}

vpc_cidr_block = "172.16.0.0/16"

public_subnets = [
  "172.16.1.0/24",
]

private_subnets = [
  "172.16.2.0/24",
]

availability_zones = [
  "us-east-1a",
]