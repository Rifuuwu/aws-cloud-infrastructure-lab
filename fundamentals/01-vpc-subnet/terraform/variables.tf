variable "aws_region" {
  description = "AWS region in which to create the lab resources."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix used for resource names."
  type        = string
  default     = "fundamentals-01"
}

variable "environment" {
  description = "Environment tag value."
  type        = string
  default     = "learning"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "subnet_cidr" {
  description = "IPv4 CIDR block for the subnet; must be inside the VPC CIDR."
  type        = string
  default     = "10.0.1.0/24"

  validation {
    condition     = can(cidrnetmask(var.subnet_cidr))
    error_message = "subnet_cidr must be a valid IPv4 CIDR block."
  }
}

variable "availability_zone" {
  description = "Optional Availability Zone for the subnet. Leave null to let AWS select one."
  type        = string
  default     = null
  nullable    = true
}
