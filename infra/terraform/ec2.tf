resource "aws_instance" "this" {
  ami = data.aws_ami.ubuntu.id

  count = lookup(var.instance, var.environment)["count"] <= 0 ? 0 : lookup(var.instance, var.environment)["count"]

  instance_type = lookup(var.instance, var.environment)["type"]

  region = lookup(var.instance, var.environment)["region"]

  tags = merge(local.common_tags, {
    "Name" = "Server ${count.index + 1}"
  })
}