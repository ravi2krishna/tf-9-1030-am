# Security Group
resource "aws_security_group" "tf-ecomm-pub-sg" {
  name        = "ecomm-web-sg"
  description = "Allow SSH & HTTP traffic"
  vpc_id      = aws_vpc.tf-ecomm.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecomm-web-sg"
  }
}

# EC2 Instance
resource "aws_instance" "tf-ecomm-pub-ec2" {
  ami           = "ami-0430580de6244e02e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf-ecomm-pub-sn-A.id
  key_name = "ravi-key"
  vpc_security_group_ids = [aws_security_group.tf-ecomm-pub-sg.id]
  user_data = file("webapp.sh")

  tags = {
    Name = "ecomm-server"
  }
}


