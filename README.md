# HedgeDoc on AWS EKS

This project automates the deployment of the **HedgeDoc Application** using **AWS EKS**, **Terraform**, **Docker**, **Helm**, and **CI/CD pipelines**. Originally set up manually using **AWS Console**, the process has been fully automated to provide a secure, scalable, and streamlined Kubernetes deployment.

**HedgeDoc** is a collaborative markdown platform that enables teams to write, edit, and share markdown documents in real-time. This deployment leverages **AWS EKS** for managed Kubernetes, with infrastructure provisioned through **Terraform** and application lifecycle management through **Argo CD** and **GitHub Actions**.

<br>

## Architecture Diagram

![AD](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/architecture-diagram.png)

<br>

## Key Components

- **Dockerisation**: Multi-stage Docker build for optimised production builds and reduced image size.

- **Infrastructure as Code (IaC)**: Terraform provisions AWS resources including VPC, EKS cluster, and related networking infrastructure.

- **Kubernetes Package Management**: Helm charts manage all cluster add-ons and components (Nginx Ingress, Cert Manager, External DNS, etc.).

- **CI/CD Pipeline**: GitHub Actions automate Docker image building, security scanning with Trivy, and Terraform deployment orchestration.

- **GitOps Deployment**: Argo CD synchronises application manifests from Git repositories to the cluster.

- **Secrets Management**: External Secrets Operator integrates AWS Secrets Manager with Kubernetes secrets.

- **RDS Database**: Manages structured application data with a managed relational database service.

- **S3 Media Storage**: S3 bucket provides scalable object storage for media uploads.

<br>

## Directory Structure

```
./
├── app/
├── .github/
│   └── workflows/
│       ├── dockerimage-ecr.yml
│       ├── terraformplan-pipeline.yml
│       ├── terraformapply-pipeline.yml
│       ├── terraformdestroy-pipeline.yml
│       ├── add-resources.yml
│       └── delete-resources.yml
├── terraform/
│   ├── bootstrap/
│   ├── deployment/
│   │   └── modules/
│   │       ├── eks/
│   │       ├── vpc/
│   │       ├── s3/
│   │       ├── rds/
│   │       └── pod-identity-association/
│   └── helm-values/
├── argo-cd/
├── cert-man/
├── secrets-manager/
├── scripts/
├── global-bundle.pem
└── Makefile

```

<br>

## Prerequisites

### 1. Local Tools Installation

Before deploying, ensure the following tools are installed locally:

- **Terraform**: Version ~> 1.14.3 or later
- **AWS CLI**: v2 or later, configured with AWS credentials
- **Docker**: Latest version for building and testing Docker images
- **kubectl**: Latest version for Kubernetes cluster management
- **Helm**: Version 3.1.1 or later for package management

### 2. AWS Account Setup

Before deploying, ensure the following AWS prerequisites are met:

- **AWS Account**: An active AWS account with appropriate permissions
- **AWS Credentials**: Configured locally via AWS CLI for Terraform to authenticate
- **Route 53 Hosted Zone**: A Route 53 hosted zone for your subdomain (e.g., `networking.rihad.co.uk`)
- **Cloudflare Account** (optional): If using Cloudflare to manage your primary domain's DNS nameservers

### 3. GitHub Actions OIDC Configuration

To enable GitHub Actions workflows to authenticate securely with AWS, configure OpenID Connect (OIDC) with an IAM role that has the necessary permissions policies (e.g., EKS, S3, etc.)

### 4. Domain Configuration

For HTTPS support and custom domain routing:

- **Primary Domain**: A domain registered through a registrar (e.g., `example.com`)
- **Route 53 Subdomain Hosted Zone**: Create a Route 53 hosted zone for your subdomain (e.g., `eks.example.com`)
- **DNS Configuration**: If using Cloudflare for your primary domain:
  - Add NS records to Cloudflare pointing to the Route 53 nameservers for your subdomain
  - This allows Route 53 to handle DNS for your EKS cluster while keeping the primary domain on Cloudflare

### 5. Terraform Configuration

Before deploying, customise the Terraform variables:

- **Bootstrap Configuration** (`terraform/bootstrap/`):
    - This creates the initial AWS infrastructure including:
      - S3 bucket for Terraform state backend
      - ECR repository for Docker images
      - Route 53 hosted zone for your subdomain
    - Run: `cd terraform/bootstrap && terraform init && terraform apply`

- **Deployment Configuration** (`terraform/deployment/`):
    - Update `provider.tf` with the S3 bucket name from bootstrap output (used for Terraform state backend)
    - Update `terraform.tfvars` with all module configurations:
      - **VPC Module**: VPC CIDR, public/private subnet CIDR blocks, availability zones, route table settings
      - **EKS Module**: Cluster name, version, IAM role, node group specifications (instance type, capacity type, desired/min/max size)
      - **Pod Identity Association Module**: IAM roles and service accounts for Cert Manager, External DNS, External Secrets Operator, and S3 access
      - **RDS Module**: Database engine, version, instance class, storage allocation, username, backup retention, multi-AZ settings
      - **S3 Module**: S3 bucket name, public access block settings

### 6. GitHub Configuration

For automated CI/CD deployment:

- **GitHub Repository**: Repository with this project code
- **GitHub Secrets**: Configure the following secrets:
    - `AWS_ACCESS_KEY_ID`: AWS access key ID for authentication
    - `AWS_SECRET_ACCESS_KEY`: AWS secret access key for authentication
    - `GitHubActionsRole`: IAM role ARN for OIDC authentication
    - `ECR_REPOSITORY`: The Amazon ECR registry URL from bootstrap output

<br>

## CI/CD Deployment Workflow

The deployment process is fully automated via GitHub Actions:

1. **Docker Image Build & Push** (`dockerimage-ecr.yml`):
    - Builds and pushes Docker images to ECR with Trivy vulnerability scanning
    - Triggered on pushes to `app/` directory or manually

2. **Terraform Plan** (`terraformplan-pipeline.yml`):
    - Previews AWS resource changes and generates tfplan artifact

3. **Terraform Apply** (`terraformapply-pipeline.yml`):
    - Downloads tfplan artifact and applies infrastructure changes (EKS, VPC, RDS, S3, etc.)

4. **Terraform Destroy** (`terraformdestroy-pipeline.yml`):
    - Destroys all Terraform-managed resources

5. **Cluster Add-ons Installation** (`add-resources.yml`):
    - Installs Helm charts via Makefile targets (Nginx Ingress, Cert Manager, External DNS, Prometheus, External Secrets)
    - Applies Kubernetes manifests for Argo CD, External Secrets, and application deployment

6. **Cluster Add-ons Deletion** (`delete-resources.yml`):
    - Uninstalls Helm charts and Kubernetes resources
    - **Cleans up S3 media uploads bucket and all objects before deletion**

To trigger any of these workflows, go to **GitHub Actions** and manually run the desired workflow.

<br>

## Deployment Steps

### Step 1: Bootstrap AWS Environment

```bash
cd terraform/bootstrap && terraform init && terraform apply
```

This creates:
- S3 bucket for Terraform state backend
- ECR repository for Docker images
- Route 53 hosted zone for your subdomain
- Outputs: S3 bucket name, ECR registry URL, Route 53 nameservers

**Important**: Note the Route 53 nameservers output. If using Cloudflare, add NS records to Cloudflare pointing to these nameservers for your subdomain.

### Step 2: Configure Terraform & GitHub Secrets

- Update `terraform/deployment/provider.tf` with the S3 bucket name from Step 1
- Update `terraform/deployment/terraform.tfvars` with all required values for VPC, EKS, Pod Identity Association, RDS, and S3 modules
- In GitHub **Settings** → **Secrets**, add: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `GitHubActionsRole`, `ECR_REPOSITORY`

### Step 3: Deploy Infrastructure

1. Run **Terraform Plan** workflow in GitHub Actions
2. Review the plan
3. Run **Terraform Apply** workflow to provision EKS cluster, VPC, pod identity associations, RDS, and S3 resources

### Step 4: Install Cluster Add-ons and Deploy Application

Use the **Cluster Add-ons Installation** (`add-resources.yml`) workflow to install all Helm charts and deploy application manifests. For individual resource provisioning and customisations, refer to the **Makefile** for available make targets.

### Step 5: Application Updates

Updates are automated: commit changes to `app/` → Docker image builds and pushes to ECR → Argo CD detects and deploys new version.


<br>

## Cleanup

Use the **Cluster Add-ons Deletion** (`delete-resources.yml`) workflow to uninstall components and clean up S3 media uploads, then use the **Terraform Destroy** (`terraformdestroy-pipeline.yml`) workflow or run locally:

```bash
cd terraform/deployment && terraform destroy
cd ../bootstrap && terraform destroy
```

<br>

## Additional Resources

- [HedgeDoc Documentation](https://docs.hedgedoc.org/)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Helm Documentation](https://helm.sh/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/)

|Here's a demo of the working application:|
|-------|
https://github.com/user-attachments/assets/963389a5-422a-45b0-a485-eec308358628

|The SSL Certificate:|
|-------|
| ![SSL Certificate](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/ssl-certificate.png) |

|ArgoCD:|
|-------|
| ![ArgoCD](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/argocd.png) |

|Prometheus and Grafana:|
|-------|
| ![Prometheus and Grafana](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/prometheus-and-grafana.png) |

|Docker Image Pipeline:|
|-------|
| ![Docker Image Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/docker-image-pipeline.png) |

|Terraform Plan Pipeline:|
|-------|
| ![Terraform Plan Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/terraform-plan-pipeline.png) |

|Terraform Apply Pipeline:|
|-------|
| ![Terraform Apply Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/terraform-apply-pipeline.png) |

|Terraform Destroy Pipeline:|
|-------|
| ![Terraform Destroy Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/terraform-destroy-pipeline.png) |

|Add Resources Pipeline:|
|-------|
| ![Add Resources Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/add-pipeline.png) |

|Delete Resources Pipeline:|
|-------|
| ![Delete Resources Pipeline](https://raw.githubusercontent.com/Rihad-A/hedgedoc-eks/main/media/delete-pipeline.png) |
