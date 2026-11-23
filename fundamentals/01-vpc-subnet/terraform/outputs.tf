
output "vpc_id" {
  description = "ID of the lab VPC."
  value       = aws_vpc.lab.id
}

output "vpc_cidr" {
  description = "CIDR block of the lab VPC."
  value       = aws_vpc.lab.cidr_block
}

output "availability_zones" {
  description = "Selected Availability Zones."
  value       = local.azs
}

output "public_subnets" {
  description = "Public subnet IDs and CIDRs by AZ."

  value = {
    for az, subnet in aws_subnet.public : az => {
      id   = subnet.id
      cidr = subnet.cidr_block
    }
  }
}

output "private_subnets" {
  description = "Private subnet IDs and CIDRs by AZ."

  value = {
    for az, subnet in aws_subnet.private : az => {
      id   = subnet.id
      cidr = subnet.cidr_block
    }
  }
}

output "nat_gateway_id" {
  description = "ID of the shared NAT Gateway."
  value       = aws_nat_gateway.lab.id
}

output "nat_gateway_az" {
  description = "Availability Zone hosting the NAT Gateway."
  value       = local.nat_gateway_az
}
