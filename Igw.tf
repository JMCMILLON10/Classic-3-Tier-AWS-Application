# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.classic_vpc.id
  tags   = { Name = "classic-igw" }
}