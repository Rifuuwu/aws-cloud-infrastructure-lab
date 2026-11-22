# 01 - VPC & Subnet

> **Status:** Scaffold — not yet deployed or validated.

## 1. Objective

Understand how an Amazon VPC provides a logically isolated network and how subnets divide its IP address space.

## 2. Scenario

Create a small, isolated network foundation for future AWS experiments. This initial scaffold defines:

- One VPC with CIDR `10.0.0.0/16`.
- One subnet with CIDR `10.0.1.0/24`.

No Internet Gateway, NAT Gateway, route table customization, EC2 instance, or public IP assignment is included yet.

## 3. Architecture

```text
AWS Region
└── VPC: 10.0.0.0/16
    └── Subnet: 10.0.1.0/24
```

Add an architecture diagram here after the design is reviewed.

## 4. Requirements and assumptions

- An active AWS Learner Lab session.
- AWS credentials with permission to create and inspect VPCs and subnets.
- Terraform CLI and AWS CLI installed.
- Region configured through `aws_region` in `terraform/variables.tf` or a local tfvars file (do not commit sensitive tfvars files).

## 5. Implementation

Terraform configuration is in [`terraform/`](terraform/).

| Resource | Purpose |
|---|---|
| `aws_vpc.lab` | Creates the isolated VPC |
| `aws_subnet.lab` | Creates a subnet inside the VPC |

## 6. Deployment

From this directory:

```bash
cd terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

Review the plan before applying. The initial configuration creates a VPC and subnet only.

## 7. Validation and testing

Not yet performed.

Suggested checks after deployment:

- Confirm the VPC CIDR is `10.0.0.0/16`.
- Confirm the subnet CIDR is `10.0.1.0/24`.
- Confirm the subnet belongs to the expected VPC.
- Record the subnet's Availability Zone.
- Confirm no Internet Gateway or NAT Gateway was created by this lab.
- Compare Terraform outputs with the AWS Console or AWS CLI.

Record actual results here. Do not mark a test as passed until it has been performed.

## 8. Troubleshooting

_To be completed during the lab._

## 9. Cost and cleanup

The initial VPC and subnet configuration does not intentionally create compute, NAT Gateway, or load-balancing resources. Check current AWS pricing and Learner Lab policies before expanding the lab.

When finished:

```bash
terraform destroy
```

Verify in the AWS Console that the lab's resources have been removed.

## 10. Lessons learned

_To be completed after the experiment._
