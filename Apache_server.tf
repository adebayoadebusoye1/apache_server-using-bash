provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

resource "aws_security_group" "sample" {   
  name_prefix = "sample"

  // Allow all inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Adebayo_instance" {
  ami             = "ami-0261755bbcb8c4a84" # Ubuntu AMI ID
  instance_type   = "t2.medium"             # Change this to your preferred instance type
  key_name = "sure"
  count = 4
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    systemctl restart apache2
    systemctl enable apache2
    echo "I will never be broke in my life!" > /var/www/html/index.html
    EOF 

  // Associate the security group with the instance
  security_groups = [aws_security_group.sample.name]

  tags = {
    Name = "Work-instance"
  }
}


output "public_ips" {
  value = aws_instance.Adebayo_instance[*].public_ip
}

