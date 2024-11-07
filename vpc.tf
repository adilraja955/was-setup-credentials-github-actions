resource "aws_vpc" "raja" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "raja-vpc"
  }
}

resource "aws_subnet" "raja-pub-1" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "raja-pub-1"
  }
}

resource "aws_subnet" "raja-pub-2" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "raja-pub-2"
  }
}


resource "aws_subnet" "raja-pub-3" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "raja-pub-3"
  }
}


resource "aws_subnet" "raja-priv-1" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "raja-priv-1"
  }
}


resource "aws_subnet" "raja-priv-2" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "raja-priv-2"
  }
}


resource "aws_subnet" "raja-priv-3" {
  vpc_id                  = aws_vpc.raja.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "raja-priv-3"
  }
}

resource "aws_internet_gateway" "raja-IGW" {
  vpc_id = aws_vpc.raja.id
  tags = {
    Name = "raja-IGW"
  }
}

resource "aws_route_table" "raja-pub-RT" {
  vpc_id = aws_vpc.raja.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.raja-IGW.id
  }

  tags = {
    Name = "raja-pub-RT"
  }
}


resource "aws_route_table_association" "raja-pub-1-a" {
  subnet_id      = aws_subnet.raja-pub-1.id
  route_table_id = aws_route_table.raja-pub-RT.id
}

resource "aws_route_table_association" "raja-pub-2-a" {
  subnet_id      = aws_subnet.raja-pub-2.id
  route_table_id = aws_route_table.raja-pub-RT.id
}
resource "aws_route_table_association" "raja-pub-3-a" {
  subnet_id      = aws_subnet.raja-pub-3.id
  route_table_id = aws_route_table.raja-pub-RT.id
}
