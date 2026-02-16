# ALB Security Group (public entry)
resource "aws_security_group" "alb_sg" {
  name        = "classic-alb-sg"
  description = "ALB ingress from internet"
  vpc_id      = aws_vpc.classic_vpc.id
  tags        = { Name = "classic-alb-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http_in" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "HTTP from internet"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id            = aws_security_group.alb_sg.id
  description                  = "ALB to app on 80"
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.app_sg.id
}

# App Security Group (private app tier)
resource "aws_security_group" "app_sg" {
  name        = "classic-app-sg"
  description = "App instances - only ALB can reach HTTP"
  vpc_id      = aws_vpc.classic_vpc.id
  tags        = { Name = "classic-app-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "app_http_from_alb" {
  security_group_id            = aws_security_group.app_sg.id
  description                  = "HTTP from ALB only"
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "app_all_out" {
  security_group_id = aws_security_group.app_sg.id
  description       = "App outbound (via NAT)"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "db_sg" {
  name        = "classic-db-sg"
  description = "DB only reachable from app tier"
  vpc_id      = aws_vpc.classic_vpc.id
  tags        = { Name = "classic-db-sg" }
}

# Example: Postgres 5432 (use 3306 if MySQL)
resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = aws_security_group.db_sg.id
  description                  = "Postgres from app tier only"
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
  referenced_security_group_id = aws_security_group.app_sg.id
}

resource "aws_vpc_security_group_egress_rule" "db_egress_all" {
  security_group_id = aws_security_group.db_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}