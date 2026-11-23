
variable "aws_region" {
  description = "AWS region for this lab."
  type        = string
  default     = "us-west-2"
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
  default     = "192.168.0.0/16"

  validation {
    condition = (
      can(cidrnetmask(var.vpc_cidr)) &&
      tonumber(split("/", var.vpc_cidr)[1]) >= 16 &&
      tonumber(split("/", var.vpc_cidr)[1]) <= 20
    )

    error_message = "vpc_cidr must be a valid IPv4 CIDR with prefix length between /16 and /20."
  }
}
