resource "aws_instance" "ec2_first" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public1_subnet.id
  availability_zone = "us-east-1a"
  security_groups = [aws_security_group.web_sg.id]

  user_data = <<EOF
#!/bin/bash
dnf update -y
dnf install nginx -y
systemctl enable nginx
systemctl start nginx
echo "server-1" > /usr/share/nginx/html/index.html
EOF

  tags = {
    Name = "ec2_first"
  }
}

resource "aws_instance" "ec2_second" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public2_subnet.id
  availability_zone = "us-east-1b"
  security_groups = [aws_security_group.web_sg.id]

  user_data = <<EOF
#!/bin/bash
dnf update -y
dnf install nginx -y
systemctl enable nginx
systemctl start nginx
echo "server-2" > /usr/share/nginx/html/index.html
EOF

  tags = {
    Name = "ec2_second"
  }
}
