# Spark Cluster Automation on GCP

Automatisation du déploiement d'un cluster Apache Spark sur Google Cloud Platform avec Terraform et Ansible.

## 🏗️ Architecture

- **VPC Custom** : `spark-vpc` (10.0.0.0/16)
- **Subnet** : `spark-subnet` (10.0.1.0/24)
- **1 Master Node** : Spark Master (10.0.1.10)
- **2 Worker Nodes** : Spark Workers (10.0.1.11-12)
- **1 Edge Node** : Job submission (10.0.1.20)

## 📋 Prérequis

- Google Cloud Platform account avec crédits
- Terraform >= 1.6
- Ansible >= 2.9
- gcloud CLI

## 🚀 Déploiement

### 1. Infrastructure Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2. Configuration Ansible (À venir)
```bash
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/spark-setup.yml
```

## 📊 Tests

WordCount application pour validation du cluster.

## 👥 Auteurs

- Nathanael FETUE
- Romero TCHIZE

## 📅 Projet

Project Infrastructure Cloud - Big Data - Décembre 2025