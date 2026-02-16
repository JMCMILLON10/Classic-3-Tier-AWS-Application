data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

resource "aws_instance" "app" {
  count                       = length(var.azs)
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_app[count.index].id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.classic_profile.name

  user_data                   = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  depends_on = [
    aws_nat_gateway.nat,
    aws_route_table_association.private_app,
    aws_route_table_association.public
  ]

  tags = { Name = "classic-app-${count.index}" }
}
