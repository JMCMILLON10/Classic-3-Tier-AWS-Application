resource "aws_vpc" "classic_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = { Name = "classic" }
}


resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.classic_vpc.id
  service_name      = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_app.id]

  tags = { Name = "classic-ddb-endpoint" }
}