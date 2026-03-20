# 🌐 Static Website Hosting on AWS with Terraform & CI/CD

![Terraform](https://img.shields.io/badge/Terraform-1.x-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-S3%20%7C%20CloudFront%20%7C%20Route53-FF9900?logo=amazonaws)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-green)

A fully automated, production-ready static website hosted on AWS — provisioned entirely with Terraform and deployed via GitHub Actions on every `git push`.

**Live demo:** [https://your-domain.com](https://your-domain.com)

---

## 📐 Architecture

```
Developer → git push → GitHub Actions
                              │
                    ┌─────────▼──────────┐
                    │     Terraform      │  (provisions infra)
                    └─────────┬──────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
           S3 Bucket       Route 53        ACM Cert
         (website files)  (DNS / domain)  (SSL / HTTPS)
              │
              ▼
          CloudFront  ←──────────────────────┘
          (CDN + HTTPS)
              │
              ▼
          End Users
```

### Services used

| Service | Purpose |
|---|---|
| **S3** | Stores and serves static website files |
| **CloudFront** | Global CDN — caches content at edge locations worldwide |
| **Route 53** | DNS management and custom domain routing |
| **ACM** | Free SSL/TLS certificate for HTTPS |
| **IAM** | Least-privilege roles and permissions |
| **GitHub Actions** | CI/CD pipeline — auto-deploys on every push to `main` |
| **Terraform** | Infrastructure as Code — provisions all AWS resources |

---

## 📁 Project structure

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD pipeline
├── terraform/
│   ├── main.tf                 # Core infrastructure resources
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Output values (e.g. CloudFront URL)
│   ├── providers.tf            # AWS provider configuration
│   └── backend.tf              # Remote state (S3 backend)
├── website/
│   ├── index.html              # Main page
│   ├── error.html              # 404 page
│   └── assets/                 # CSS, JS, images
└── README.md
```

---

## 🚀 Getting started

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.0+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured (`aws configure`)
- An AWS account with appropriate permissions
- A registered domain in Route 53 (optional but recommended)

### 1. Clone the repository

```bash
git clone https://github.com/your-username/aws-static-website-terraform.git
cd aws-static-website-terraform
```

### 2. Configure variables

Create a `terraform/terraform.tfvars` file:

```hcl
aws_region      = "us-east-1"
domain_name     = "your-domain.com"
bucket_name     = "your-unique-bucket-name"
environment     = "production"
```

### 3. Deploy infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Set up GitHub Actions secrets

In your GitHub repository go to **Settings → Secrets and variables → Actions** and add:

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key |
| `S3_BUCKET_NAME` | Your S3 bucket name |
| `CLOUDFRONT_DISTRIBUTION_ID` | Your CloudFront distribution ID |

### 5. Push to deploy

```bash
git add .
git commit -m "feat: update website content"
git push origin main
# GitHub Actions automatically deploys your changes
```

---

## ⚙️ CI/CD pipeline

The pipeline runs automatically on every push to `main`:

```
push to main
     │
     ├── 1. Checkout code
     ├── 2. Configure AWS credentials
     ├── 3. Setup Terraform
     ├── 4. terraform init
     ├── 5. terraform plan
     ├── 6. terraform apply
     ├── 7. Sync files → S3
     └── 8. Invalidate CloudFront cache
```

See [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) for the full workflow definition.

---

## 🔒 Security highlights

- **Private S3 bucket** — website files are never publicly accessible directly; all traffic goes through CloudFront
- **HTTPS enforced** — CloudFront redirects all HTTP requests to HTTPS
- **Least-privilege IAM** — the deployment user only has the permissions it needs (S3 write + CloudFront invalidation)
- **No hardcoded credentials** — all secrets are stored in GitHub Secrets and injected at runtime

---

## 💡 Key Terraform concepts demonstrated

- **Providers** — configuring the AWS provider with region and credentials
- **Resources** — defining S3 buckets, CloudFront distributions, Route 53 records
- **Variables & outputs** — parameterizing infrastructure and exposing useful values
- **Remote state** — storing Terraform state in S3 for team collaboration
- **Data sources** — referencing existing AWS resources (e.g. ACM certificates)

---

## 🌱 Possible extensions

- Add a **staging environment** with a separate Terraform workspace
- Enable **S3 versioning** for rollback capability
- Set up **CloudWatch alarms** for error rate monitoring
- Add **WAF rules** to the CloudFront distribution for security
- Implement **multi-region failover** with Route 53 health checks

---

## 📚 Resources

- [Terraform AWS Provider docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS S3 static website hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [GitHub Actions documentation](https://docs.github.com/en/actions)

---

## 📄 License

MIT — feel free to use this as a starting point for your own projects.

---

*Built as a portfolio project to demonstrate AWS infrastructure automation with Terraform and CI/CD pipelines.*
