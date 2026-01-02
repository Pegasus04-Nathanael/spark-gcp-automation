# Spark Cluster Automation on GCP

[![Terraform CI](https://github.com/Pegasus04-Nathanael/spark-gcp-automation/actions/workflows/terraform-validate.yml/badge.svg)](https://github.com/Pegasus04-Nathanael/spark-gcp-automation/actions)

Production-ready Infrastructure as Code for deploying distributed Apache Spark clusters on Google Cloud Platform.

## Project Overview

Automated deployment pipeline combining Terraform and Ansible to provision and configure multi-node Spark clusters. Built with modern DevOps practices, this solution enables reproducible deployments in under 10 minutes.

**Key achievements:**
- Zero-touch deployment of 4-node cluster (1 master, 2 workers, 1 edge)
- Automated configuration management across all nodes
- Performance benchmarking with real-world workloads
- Cost-optimized infrastructure design
- **CI/CD validation** with GitHub Actions

## Technical Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Infrastructure | Terraform 1.6+ | Cloud resource provisioning |
| Configuration | Ansible 2.9+ | Service deployment and config |
| Big Data | Apache Spark 3.5.0 | Distributed computing framework |
| Cloud | Google Cloud Platform | Compute, networking, storage |
| OS | Ubuntu 22.04 LTS | Base operating system |
| CI/CD | GitHub Actions | Automated validation |

## Architecture
```
VPC: spark-vpc (10.0.0.0/16)
│
└── Subnet: spark-subnet (10.0.1.0/24)
    │
    ├── spark-master (10.0.1.10)    # Cluster orchestration
    ├── spark-worker-1 (10.0.1.11)  # Task execution
    ├── spark-worker-2 (10.0.1.12)  # Task execution
    └── spark-edge (10.0.1.20)      # Job submission node
```

**Security features:**
- Isolated VPC with custom firewall rules
- SSH key-based authentication only
- Minimal port exposure (22, 7077, 8080, 4040)
- Internal-only communication between cluster nodes

## Quick Start

### Prerequisites
```bash
# Required tools
- Terraform >= 1.6.0
- Ansible >= 2.9
- gcloud CLI (authenticated)
- SSH key pair
```

### Deploy Infrastructure
```bash
# 1. Provision cloud resources
cd terraform
terraform init
terraform apply

# 2. Configure Spark cluster
cd ../ansible
./update-inventory.sh
ansible-playbook -i inventory/hosts.ini playbooks/spark-setup.yml

# 3. Verify deployment
ansible -i inventory/hosts.ini all -m ping
```

**Total deployment time:** ~8 minutes

## Performance Results

Tested with Shakespeare complete works (5.3 MB, 124K lines):

| Configuration | Cores | Execution Time | Speedup |
|--------------|-------|----------------|---------|
| 1 executor × 1 core | 1 | 19.56s | 1.00x (baseline) |
| 2 executors × 1 core | 2 | 18.94s | 1.03x |
| 2 executors × 2 cores | 4 | 11.91s | 1.64x |

**Key findings:**
- 59,508 unique words identified
- Speedup limited by Amdahl's Law (~40% sequential code)
- Overhead dominates on small files; production workloads scale better

See `RESULTS.md` for detailed performance analysis.

## CI/CD Pipeline

Every push triggers automated validation:

**Terraform Checks:**
- ✅ Code formatting (`terraform fmt`)
- ✅ Configuration validation (`terraform validate`)
- ✅ Syntax verification

**Ansible Checks:**
- ✅ YAML linting
- ✅ Playbook syntax validation
- ✅ Best practices enforcement

## Project Structure
```
spark-gcp-automation/
├── .github/
│   └── workflows/
│       └── terraform-validate.yml  # CI/CD pipeline
├── terraform/                       # Infrastructure provisioning
│   ├── main.tf                     # VPC, compute instances, firewall
│   ├── variables.tf                # Configurable parameters
│   └── outputs.tf                  # IP addresses, resource IDs
├── ansible/                        # Configuration management
│   ├── inventory/                  # Dynamic inventory with IP updates
│   ├── playbooks/                  # Spark installation and setup
│   └── update-inventory.sh         # Auto-refresh public IPs
├── wordcount/                      # Benchmark application
│   └── wordcount.py                # PySpark word count with metrics
├── RESULTS.md                      # Performance analysis
└── README.md                       # This file
```

## Key Features

### Infrastructure as Code
- **Reproducible:** Identical deployments every time
- **Versionable:** Infrastructure changes tracked in Git
- **Scalable:** Easily adjust cluster size via variables
- **Cost-effective:** Automated teardown prevents waste

### Automation
- One-command deployment and destruction
- Dynamic IP management for ephemeral infrastructure
- Automated SSH key distribution
- Service health checks and validation

### Production-Ready
- Proper network isolation (VPC)
- Security best practices (firewall, SSH-only)
- CI/CD validation before deployment
- Documented troubleshooting procedures

## Common Operations

### Update IPs after VM restart
```bash
cd ansible
./update-inventory.sh
```

### Restart Spark services
```bash
# Master node
ssh spark@<master-ip> "/opt/spark/sbin/start-master.sh"

# Worker nodes (on each)
ssh spark@<worker-ip> "/opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077"
```

### Run performance tests
```bash
ssh spark@<edge-ip>
cd wordcount
time /opt/spark/bin/spark-submit \
  --master spark://10.0.1.10:7077 \
  --executor-cores 2 --num-executors 2 \
  wordcount.py /home/spark/input.txt results.txt
```

### Destroy infrastructure
```bash
cd terraform
terraform destroy
```

## Skills Demonstrated

- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- Cloud Architecture (GCP)
- Distributed Systems (Apache Spark)
- CI/CD (GitHub Actions)
- Shell Scripting (Bash)
- Performance Analysis
- Git workflow

## Authors

- Nathanael FETUE
- Romero TCHIAZE

## Resources

- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Performance Analysis Report](RESULTS.md)
