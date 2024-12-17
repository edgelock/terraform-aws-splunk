# ----------------------------
# VPC Creation
# ----------------------------
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "tf-example-2"
  }
}

# ----------------------------
# Subnet Creation
# ----------------------------
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet
  availability_zone       = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet"
  }
}

# ----------------------------
# Internet Gateway Setup
# ----------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

# ----------------------------
# Route Table and Association
# ----------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_main_route_table_association" "association" {
  vpc_id         = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.public.id
}

# ----------------------------
# Security Group for Splunk Instance
# ----------------------------
resource "aws_security_group" "splunk_sg" {
  name        = "Splunk SG"
  description = "Splunk Security Group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "API Access"
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["${local.public_ip}/32"]
  }

  ingress {
    description = "UI Access"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${local.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "splunk_sg"
  }
}

# ----------------------------
# Network Interface
# ----------------------------
resource "aws_network_interface" "network_interface" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.splunk_sg.id]
  tags = {
    Name = "primary_network_interface"
  }
}

# ----------------------------
# EC2 Instance Creation
# ----------------------------
resource "aws_instance" "splunk" {
  ami           = data.aws_ami.splunk.id
  instance_type = var.instance_type
  availability_zone = data.aws_availability_zones.AZ.names[0]

  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }

  tags = {
    Name = "splunk-terraform"
  }
}
