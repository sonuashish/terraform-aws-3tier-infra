locals {
  ingress_rules = [
    { port = 443, description = "HTTPS" },
    { port = 80,  description = "HTTP" },
    { port = 8080, description = "APP" }
  ]
}


resource "aws_vpc" "myVPC" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support
    tags = {
        Name = "${var.env}-VPC"
    }
}

resource "aws_internet_gateway" "myIGW" {
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "${var.env}-internet_gateway"
    }
}



resource "aws_subnet" "Public_Subnet" {
    count = length(var.public_subnet_cidr_block)
    vpc_id = aws_vpc.myVPC.id
    cidr_block = var.public_subnet_cidr_block[count.index]
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.env}-Public-Subnet"
    }
}

resource "aws_subnet" "Private_Subnet" {
    count = length(var.private_subnet_cidr_block)
    vpc_id = aws_vpc.myVPC.id
    cidr_block = var.private_subnet_cidr_block[count.index]
    availability_zone = "ap-south-1b"
    tags = {
        Name = "${var.env}-Private-Subnet"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "${var.env}-public_route_table"
    }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.myVPC.id
    tags = {
        Name = "${var.env}-private_route_table"
    }
}

resource "aws_route_table_association" "public_assoc" {
  count = length(aws_subnet.Public_Subnet)

  subnet_id      = aws_subnet.Public_Subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_assoc" {
  count = length(aws_subnet.Private_Subnet)

  subnet_id      = aws_subnet.Private_Subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.Public_Subnet[0].id

  tags = {
    Name = "${var.env}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.myIGW]
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


resource "aws_security_group" "main" {
  description = "Allowed Inbound and Outbound traffic"
  vpc_id      = aws_vpc.myVPC.id

  egress {
    description = "Outbound Rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "${var.env}-Main-aws_security_group"
  }
}
