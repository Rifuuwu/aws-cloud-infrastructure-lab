# AWS Fundamentals

Focused experiments for learning AWS services and infrastructure concepts.

Each lab should be independently understandable and, where practical, independently deployable and destroyable.

## Lab index

| Lab | Topic | Status |
|---|---|---|
| [01 - VPC & Subnet](01-vpc-subnet/README.md) | VPC, CIDR, subnet, and availability zones | Scaffold |

## Lab conventions

Each lab should generally contain:

```text
NN-lab-name/
├── terraform/
│   ├── terraform.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ...
├── evidence/
└── README.md
```

Keep each lab's Terraform state isolated. Do not reuse one lab's state directory for another lab.
