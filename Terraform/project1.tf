
TERRAFORM ACTUAL MAIN.TF FILE
#PROVIDER
provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}
#CREATING VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demo_vpc"
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo_igw"
  }
}

#PUBLIC SUBNET
resource "aws_subnet" "demo_pub" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "demo_pub"
  }
}

#PRIVATE SUBNET
resource "aws_subnet" "demo_pri" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "demo_pri"
  }
}

#ELASTIC IP
resource "aws_eip" "demo_eip" {
  domain = "vpc"
}

#NAT GATEWAY
resource "aws_nat_gateway" "demo_nat" {
  allocation_id = aws_eip.demo_eip.id
  subnet_id     = aws_subnet.demo_pub.id
  tags = {
    Name = "NATGateway"
  }
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "demo_pubrt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo_rt"
  }
}

#PUBLIC INTERNET ACCESS
resource "aws_route" "demo_pub_ia" {
  route_table_id         = aws_route_table.demo_pubrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo_igw.id
}

#PUBLIC ROUTE TABLE ASSOCIATE WITH PUBLIC SUBNET
resource "aws_route_table_association" "demo_a" {
  subnet_id      = aws_subnet.demo_pub.id
  route_table_id = aws_route_table.demo_pubrt.id
}

#PRIVATE ROUTE TABLE
resource "aws_route_table" "demo_prirt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo_prt"
  }
}

#PRIVATE NATGATEWAY
resource "aws_route" "demo_pri_nat" {
  route_table_id         = aws_route_table.demo_prirt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.demo_nat.id
}

#PRIVATE ROUTE TABLE ASSOCIATE WITH PRIVATE SUBNET
resource "aws_route_table_association" "demo_rt_as" {
  subnet_id      = aws_subnet.demo_pri.id
  route_table_id = aws_route_table.demo_prirt.id
}

#SECURITY GROUP
resource "aws_security_group" "demo_pub_sg" {
  name   = "demo_pub_sg"
  vpc_id = aws_vpc.demo_vpc.id

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "demo_pri_sg" {
    vpc_id = aws_vpc.demo_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#PUBLIC INSTANCE
resource "aws_instance" "demo-pub-ins" {
  ami                         = "ami-02ddb77f8f93ca4ca"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.demo_pub.id
  security_groups             = [aws_security_group.demo_pub_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to My Web Server!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ec2-user-public"
  }
}

#PRIVATE INSTANCE
resource "aws_instance" "demo-pri-ins" {
  ami                         = "ami-02ddb77f8f93ca4ca"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.demo_pri.id
  security_groups             = [aws_security_group.demo_pri_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "ec2-user-private"
  }
}
