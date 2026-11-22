# AWS Cloud Infrastructure Lab

A hands-on learning and portfolio repository for AWS cloud infrastructure, networking, and operations.

The repository documents infrastructure as code (IaC), experiments, validation results, operational procedures, and lessons learned. Terraform is used as the primary provisioning tool so that infrastructure definitions can be reviewed, version-controlled, and reproduced.

> **Important:** Terraform describes and manages infrastructure; it does not guarantee that the design is correct or secure. Every lab must include validation and testing evidence.


## Learning objectives

- Understand AWS networking and infrastructure fundamentals.
- Practice Infrastructure as Code with Terraform.
- Learn to validate, troubleshoot, and operate cloud resources.
- Document design decisions, trade-offs, costs, and limitations.
- Build repeatable, reviewable portfolio projects.

## Repository structure

```text
aws-cloud-infrastructure-lab/
├── fundamentals/
│   └── NN-lab-name/
│       ├── terraform/
│       │   ├── terraform.tf
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       │   └── ....
│       ├── evidence/
│       └── README.md
├── projects/
│   └── README.md
├── docs/
│   ├── architecture/
│   ├── network-design/
│   ├── decisions/
│   ├── troubleshooting/
│   └── README.md
├── .gitignore
└── README.md
```

### Directory responsibilities

- **`fundamentals/`** — focused experiments that teach one or a few AWS concepts. Each lab contains its own Terraform configuration, README, and relevant evidence.
- **`projects/`** — larger, scenario-driven implementations that combine multiple concepts into a realistic solution.
- **`docs/`** — shared documentation that spans multiple labs or projects: architecture conventions, network design references, design decisions, and troubleshooting notes.
- **`evidence/`** — sanitized test output, screenshots, diagrams, and logs that help demonstrate what was actually deployed and tested.

## Getting started

### Prerequisites

- An AWS Learner Lab environment with permission to create the resources used by a lab.
- Terraform CLI.
- AWS CLI.
- Valid temporary AWS credentials for the active Learner Lab session.

### Typical Terraform workflow

Run commands from the relevant lab's `terraform/` directory:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

Review the plan before applying. When the experiment is finished, remove resources managed by that lab:

```bash
terraform destroy
```

Temporary Learner Lab credentials expire. Refresh them when necessary. Do not put credentials in Terraform files, variable files committed to Git, screenshots, or logs.

### State and safety

- Terraform state files are intentionally excluded from Git because they can contain sensitive data.
- Commit `.terraform.lock.hcl` after `terraform init` to record provider selections and checksums.
- Keep each lab's Terraform configuration and state isolated in its own directory.
- Do not delete state manually while its resources still exist.
- `terraform destroy` only manages resources tracked by the relevant state; verify the AWS Console for leftovers.
- Check AWS pricing and Learner Lab restrictions before creating resources. Some resources can incur charges even when idle.

## Lab documentation template

Use this outline in each lab's `README.md`:

1. **Objective** — what problem or concept is being explored?
2. **Scenario** — what is the practical context?
3. **Architecture** — diagram and explanation of components.
4. **Requirements and assumptions** — region, CIDR plan, permissions, constraints.
5. **Implementation** — Terraform resources and important configuration choices.
6. **Deployment** — commands and deployment procedure.
7. **Validation and testing** — expected behavior, test cases, and actual results.
8. **Troubleshooting** — issues encountered and how they were resolved.
9. **Cost and cleanup** — cost considerations and resource cleanup procedure.
10. **Lessons learned** — what changed in your understanding?

## Evidence guidelines

Prefer evidence that demonstrates behavior, not just that a resource exists:

- Terraform plan/apply output with sensitive values removed.
- Sanitized AWS Console screenshots where useful.
- CLI test results (for example, routing or connectivity tests).
- Architecture diagrams and concise test tables.
- Notes about expected versus observed behavior.

Never publish access keys, secret keys, session tokens, private keys, unredacted account details, or sensitive state files.

## Disclaimer

This repository is a learning and portfolio project. Resource availability, IAM permissions, service limits, and costs depend on the AWS account and Learner Lab environment used.
