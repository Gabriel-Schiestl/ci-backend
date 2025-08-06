resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = merge(local.common_tags, {
    "Name" = "VPC ${terraform.workspace}"
  })
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(local.common_tags, {
    "Name" = "Public Subnet ${count.index + 1} ${terraform.workspace}"
  })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(local.common_tags, {
    "Name" = "Private Subnet ${count.index + 1} ${terraform.workspace}"
  })
}