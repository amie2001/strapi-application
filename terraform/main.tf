provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "strapi_sg_task4" {
  name        = "strapi-sg-task4"
  description = "Security group for Strapi EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH (you can restrict later for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access (port 80)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound
  }
}

resource "aws_instance" "strapi_task4" {
  ami                         = "ami-0e35ddab05955cf57" # Amazon Linux 2 AMI (Mumbai region)
  instance_type               = "t2.medium"
  key_name                    = "strapi-using-docker"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.strapi_sg_task4.name]
  iam_instance_profile        = "EC2ECRAccessRole" # Make sure the Role is attached

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io unzip
    systemctl start docker
    usermod -aG docker ubuntu

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    # Login to Amazon ECR
    aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 864899875002.dkr.ecr.ap-south-1.amazonaws.com

    # Pull and Run the Strapi Docker image
    docker pull ${var.ecr_repository}:${var.image_tag}

    docker run -d -p 80:1337 \
      -e APP_KEYS="toBeModified1,toBeModified2" \
      -e API_TOKEN_SALT="tobemodified" \
      -e ADMIN_JWT_SECRET="tobemodified" \
      -e TRANSFER_TOKEN_SALT="tobemodified" \
      -e JWT_SECRET="tobemodified" \
      ${var.ecr_repository}:${var.image_tag}
  EOF

  tags = {
    Name = "StrapiApp"
  }
}
