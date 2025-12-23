# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  
  tags = {
    Name        = "${var.environment}-web-server"
    Environment = var.environment
    Project     = "BYOD-3"
  }

  # Security group
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
    Name        = "${var.environment}-web-sg"
    Environment = var.environment
  }
}
