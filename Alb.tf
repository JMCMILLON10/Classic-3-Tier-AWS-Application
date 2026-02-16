resource "aws_lb" "alb" {
  name               = "classic-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id

  tags = { Name = "classic-alb" }
}



