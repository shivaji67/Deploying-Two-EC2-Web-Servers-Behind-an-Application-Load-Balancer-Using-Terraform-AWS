resource "aws_lb" "alb" {
  name               = "myalb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public1_subnet.id, aws_subnet.public2_subnet.id]
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id  = aws_vpc.my_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_target_group_attachment" "a1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2_first.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "a2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2_second.id
  port             = 80
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


