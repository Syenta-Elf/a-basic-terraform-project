# 🐳 Local Docker Infrastructure Manager

A basic Terraform project that manages a local Docker infrastructure with Nginx, Redis, and PostgreSQL containers connected through a private network.

## Stack

- **Terraform** — Infrastructure as Code
- **Docker** — Container runtime
- **Provider** — [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)

## Architecture

<img width="834" height="469" alt="image" src="https://github.com/user-attachments/assets/714f3d18-63fe-41bf-975f-a8cc1a8821c7" />


- **nginx** is the only container exposed to the host machine
- **redis** and **postgres** are only accessible within the private Docker network
- All containers communicate with each other using container names via Docker's internal DNS

## Project Structure

```
a-basic-terraform-project/
├── main.tf                 # Network, images, and containers
├── outputs.tf              # Container ports and IP addresses
├── providers.tf            # Docker provider configuration
├── terraform.tfvars        # Variable values (gitignored)
├── variables.tf            # Variable definitions
└── README.md
```

## Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Getting Started

**1. Clone the repository**

```bash
git clone https://github.com/<your-username>/a-basic-terraform-project.git
cd a-basic-terraform-project
```

**2. Create your `terraform.tfvars` file**

```hcl
image_list = {
  "nginx" = {
    tag           = "1.29.8-alpine"
    internal_port = 80
    external_port = 8081
  }
  "redis" = {
    tag           = "8.6.2-alpine"
    internal_port = 6379
  }
  "postgres" = {
    tag = "18.3-alpine3.23"
    env = ["POSTGRES_PASSWORD=your_password"]
  }
}
```

**3. Initialize Terraform**

```bash
terraform init
```

**4. Apply the configuration**

```bash
terraform apply
```

**5. Verify containers are running**

```bash
docker ps
```

**6. Destroy the infrastructure**

```bash
terraform destroy
```

## Outputs

| Output | Description |
|--------|-------------|
| `container_ports` | External and internal port mappings |
| `container_addresses` | IP addresses within the private network |

## What You'll Learn

- `resource`, `variable`, `output` blocks
- `for_each` for dynamic resource creation
- `dynamic` blocks for conditional configuration
- Docker provider usage
- Private networking between containers
- State management with `terraform.tfstate`
