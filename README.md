cat > README.md << 'EOF'
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
- CI/CD validation with GitHub Actions

## Architecture
```
VPC: spark-vpc (10.0.0.0/16)
│
└── Subnet: spark-subnet (10.0.1.0/24)
    │
    ├── spark-master (10.0.1.10)    # Cluster orchestration, Web UI
    ├── spark-worker-1 (10.0.1.11)  # Task execution (2 cores)
    ├── spark-worker-2 (10.0.1.12)  # Task execution (2 cores)
    └── spark-edge (10.0.1.20)      # Job submission node
```

**Communication flows:**
- User → Edge via SSH (port 22) to submit jobs
- User → Master Web UI via HTTP (port 8080) to monitor cluster
- Edge → Master (port 7077) internal communication for job submission
- Master → Workers internal communication for task distribution
- Workers ↔ Workers internal data shuffle

## Quick Start (First Time)

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

# 3. Restart Workers manually (one-time fix)
ssh codespace@<WORKER1_IP> "sudo -u spark /opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077"
ssh codespace@<WORKER2_IP> "sudo -u spark /opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077"

# 4. Copy test file to all nodes
ssh codespace@<WORKER1_IP> "sudo cp /home/codespace/input.txt /opt/spark/"
ssh codespace@<WORKER2_IP> "sudo cp /home/codespace/input.txt /opt/spark/"
ssh codespace@<EDGE_IP> "sudo cp /home/codespace/input.txt /opt/spark/"

# 5. Stop VMs to save costs
gcloud compute instances stop spark-master spark-worker-1 spark-worker-2 spark-edge --zone=europe-west1-b
```

**Total deployment time:** ~10 minutes

## Next Time (Restart Cluster)
```bash
# 1. Authenticate with GCP
gcloud auth login

# 2. Run the start script
./start-cluster.sh

# 3. Connect to Edge and run tests
ssh codespace@<EDGE_IP_displayed>

# 4. Run WordCount
time /opt/spark/bin/spark-submit \
  --master spark://10.0.1.10:7077 \
  --executor-cores 2 --num-executors 2 \
  wordcount.py /opt/spark/input.txt results.txt
```

**Restart time:** 3-4 minutes

## Performance Results

Tested with Shakespeare complete works (5.2 MB, 196K lines):

| Test | Executors | Cores/Exec | Total Cores | Spark Time | Total Time | Speedup |
|------|-----------|------------|-------------|------------|------------|---------|
| 1 | 1 | 1 | 1 | 24.56s | 33.06s | 1.00x |
| 2 | 2 | 1 | 2 | 22.92s | 31.16s | 1.07x |
| 3 | 2 | 2 | 4 | 15.73s | 23.90s | 1.56x |

**Key findings:**
- 63,103 unique words identified
- Speedup limited by Amdahl's Law (~35-40% sequential code)
- Best performance with 2 executors × 2 cores (utilizing all 4 available cores)
- Small file size (5.2 MB) limits scalability benefits

## Technical Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Infrastructure | Terraform 1.6+ | Cloud resource provisioning |
| Configuration | Ansible 2.9+ | Service deployment and config |
| Big Data | Apache Spark 3.5.0 | Distributed computing framework |
| Cloud | Google Cloud Platform | Compute, networking, storage |
| OS | Ubuntu 22.04 LTS | Base operating system |
| CI/CD | GitHub Actions | Automated validation |

## Project Structure
```
spark-gcp-automation/
├── start-cluster.sh                # Quick restart script
├── terraform/                      # Infrastructure provisioning
│   ├── main.tf                     # VPC, compute, firewall
│   ├── variables.tf                # Configuration parameters
│   └── outputs.tf                  # IP addresses, resource IDs
├── ansible/                        # Configuration management
│   ├── inventory/hosts.ini         # Dynamic inventory
│   ├── playbooks/                  # Spark installation
│   └── update-inventory.sh         # Auto-refresh IPs
├── wordcount/                      # Benchmark application
│   └── wordcount.py                # PySpark word count
└── RESULTS.md                      # Performance analysis
```

## Common Operations

### Stop VMs (save costs)
```bash
gcloud compute instances stop spark-master spark-worker-1 spark-worker-2 spark-edge \
  --zone=europe-west1-b
```

### Restart cluster
```bash
./start-cluster.sh
```

### Run performance tests
```bash
ssh codespace@<edge-ip>
time /opt/spark/bin/spark-submit \
  --master spark://10.0.1.10:7077 \
  --executor-cores 2 --num-executors 2 \
  wordcount.py /opt/spark/input.txt results.txt
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
EOF