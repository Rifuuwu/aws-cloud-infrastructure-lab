provider "aws" {
  region = var.aws_region
}

# Discover available Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Select two AZs and allocate subnet CIDRs
locals {
  public_subnets = {
    az_a = {
      cidr_block = "192.168.0.0/24"
      az_index   = 0
    }
    az_b = {
      cidr_block = "192.168.2.0/24"
      az_index   = 1
    }
  }

  private_subnets = {
    az_a = {
      cidr_block = "192.168.1.0/24"
      az_index   = 0
    }
    az_b = {
      cidr_block = "192.168.3.0/24"
      az_index   = 1
    }
  }

  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )

  nat_gateway_az = "az_a"
}

# --------------------------------------------------
# VPC
# --------------------------------------------------

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

# --------------------------------------------------
# Internet Gateway
# --------------------------------------------------

resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name        = "${var.name_prefix}-igw"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --------------------------------------------------
# Public Subnets
# --------------------------------------------------

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr_block
  availability_zone = local.azs[each.value.az_index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.name_prefix}-public-${each.key}"
    Tier        = "public"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --------------------------------------------------
# Private Subnets
# --------------------------------------------------

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr_block
  availability_zone = local.azs[each.value.az_index]

  tags = {
    Name        = "${var.name_prefix}-private-${each.key}"
    Tier        = "private"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# --------------------------------------------------
# Public Route Table
# --------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name        = "${var.name_prefix}-public-rt"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# --------------------------------------------------
# Elastic IP and NAT Gateway
# --------------------------------------------------

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${var.name_prefix}-nat-eip"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_nat_gateway" "lab" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[local.nat_gateway_az].id

  tags = {
    Name        = "${var.name_prefix}-nat-gateway"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_route.public_internet,
    aws_route_table_association.public
  ]
}

# --------------------------------------------------
# Private Route Tables
# One route table per AZ, both using the same NAT GW
# --------------------------------------------------

resource "aws_route_table" "private" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.lab.id

  tags = {
    Name        = "${var.name_prefix}-private-rt-${each.key}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_route" "private_nat" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.lab.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
