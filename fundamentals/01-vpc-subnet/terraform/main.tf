provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "lab" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name_prefix}-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "lab" {
  vpc_id     = aws_vpc.lab.id
  cidr_block = var.subnet_cidr

  # Leave unset by default so AWS can select an available AZ.
  # Set availability_zone in variables.tf if the lab requires a specific AZ.
  availability_zone = var.availability_zone

  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.name_prefix}-subnet"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
