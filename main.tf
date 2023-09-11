resource "aws_security_group" "allow_tls" {
  name        = "sample-application-SG"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sample-application-SG"
  }
}

resource "aws_lb" "web" {
  name               = "sample-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = data.aws_subnets.public.ids

  tags = {
    Name = "sample-loadbalancer"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "sample-application-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
  health_check {
    matcher = 200
    path    = "/"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
