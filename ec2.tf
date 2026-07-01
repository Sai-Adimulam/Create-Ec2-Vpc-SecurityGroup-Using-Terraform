# Create provider
provider "aws" {
  region = "ap-south-2"
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC-1"
  }
}
#create IGW
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "IGW-1"
  }
}
# Create Public Subnet
resource "aws_subnet" "my_subnet" {
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-2a"
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

# Create Route Table
resource "aws_route_table" "Rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "Route-1"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.Rt.id
}

# Create Security Group 
resource "aws_security_group" "sg" {
  name        = "Ec2-Security-Group"
  description = "sg for ec2"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
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
    Name = "Security-1"
  }
}
# Create Ec2
resource "aws_instance" "ec2" {
  ami                         = "ami-0ffa797f35095b9f7"
  instance_type               = "t3.micro"
  key_name                    = "key-1"
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.my_subnet.id
  associate_public_ip_address = true
  count                       = 5

  tags = {
    Name = "instance-${count.index + 1}"
  }
}

