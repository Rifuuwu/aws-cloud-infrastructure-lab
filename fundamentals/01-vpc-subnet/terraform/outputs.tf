output "vpc_id" {
  description = "ID of the lab VPC."
  value       = aws_vpc.lab.id
}

output "vpc_cidr" {
  description = "IPv4 CIDR block of the lab VPC."
  value       = aws_vpc.lab.cidr_block
}

output "subnet_id" {
  description = "ID of the lab subnet."
  value       = aws_subnet.lab.id
}

output "subnet_cidr" {
  description = "IPv4 CIDR block of the lab subnet."
  value       = aws_subnet.lab.cidr_block
}

output "subnet_availability_zone" {
  description = "Availability Zone selected for the lab subnet."
  value       = aws_subnet.lab.availability_zone
}
