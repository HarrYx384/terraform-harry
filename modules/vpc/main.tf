resource "aws_vpc" "wipro" {
  cidr_block       = $var.cidr
  instance_tenancy = $var.tena

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "sg-for-own" {
  vpc_id     = ${var.vpc-id}
  cidr_block = "${var.subnetrange}"

  tags = {
    Name = "Main"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.wipro.id

  ingress  {
      description      = "allow ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.wipro.cidr_block]
 
    }

  ingress  {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

   ingress  {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "-1"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

  egress    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_internet_gateway" "internet-access" {
  vpc_id = ${var.vpc-id}

  tags = {
    Name = "internet-gatewaye"
  }
}


resource "aws_route_table" "routtableforpub" {
  vpc_id = ${var.vpc-id}

  route    {
      cidr_block = ${var.subnetrange}
      gateway_id = ${var.igw}
    }

  tags = {
    Name = "pubsubnet"
  }
}
