resource "aws_lb_target_group" "app_tg" {
  name        = "classic-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.classic_vpc.id
  target_type = "instance"

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
  }

  tags = { Name = "classic-app-tg" }
}

resource "aws_lb_target_group_attachment" "app" {
  count            = length(var.azs)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}