resource "aws_instance" "this" {
  ami = data.aws_ami.ubuntu.id

  count = lookup(var.instance, "count") <= 0 ? 0 : lookup(var.instance, "count")

  instance_type = lookup(var.instance, "type")

  tags = merge(local.common_tags, {
    "Name" = "Server ${count.index + 1}"
  })
}