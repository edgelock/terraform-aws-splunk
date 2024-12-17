# Get Availability Zones in the selected AWS region
data "aws_availability_zones" "AZ" {}

# Get the user's public IP
data "http" "my_public_ip" {
  url = "https://ipinfo.io/json"
  request_headers = {
    Accept = "application/json"
  }
}

# Fetch the latest Splunk AMI
data "aws_ami" "splunk" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["splunk_AMI*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
