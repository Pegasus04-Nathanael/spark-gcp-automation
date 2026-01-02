# Spark Cluster Automation on GCP

Automatisation du déploiement d'un cluster Apache Spark sur Google Cloud Platform avec Terraform et Ansible.

## Auteurs
- Nathanael FETUE
- Romero TCHIAZE

**Projet** : Infrastructure Cloud - Big Data  
**Date** : Décembre 2025

---

## Architecture
```
VPC: spark-vpc (10.0.0.0/16)
│
└── Subnet: spark-subnet (10.0.1.0/24)
    │
    ├── spark-master (10.0.1.10) - Gestion du cluster
    ├── spark-worker-1 (10.0.1.11) - Exécution des tâches
    ├── spark-worker-2 (10.0.1.12) - Exécution des tâches
    └── spark-edge (10.0.1.20) - Soumission des jobs
```

**Sécurité** :
- Firewall : SSH (22), Spark Master UI (8080), Communication (7077, 4040)
- Authentification par clés SSH uniquement
- VPC isolé avec communication interne complète

---

## Prérequis

- Google Cloud Platform (compte avec crédits)
- Terraform >= 1.6.0
- Ansible >= 2.9
- gcloud CLI configuré
- Clé SSH générée

---

## Déploiement

### 1. Infrastructure (Terraform)
```bash
cd terraform
terraform init
terraform plan
terraform apply

# Récupérer les IPs
terraform output
```

**Ressources créées** :
- 1 VPC custom (spark-vpc)
- 1 Subnet (10.0.1.0/24)
- 3 règles Firewall
- 4 instances Compute Engine (e2-medium, Ubuntu 22.04)

### 2. Configuration (Ansible)
```bash
cd ansible

# Mise à jour automatique des IPs
./update-inventory.sh

# Test connectivité
ansible -i inventory/hosts.ini all -m ping

# Déploiement Spark
ansible-playbook -i inventory/hosts.ini playbooks/spark-setup.yml
```

**Configuration déployée** :
- Apache Spark 3.5.0
- Java OpenJDK 11
- Python 3.10
- Configuration Master/Workers

### 3. Application WordCount
```bash
# Connexion au edge node
ssh spark@<IP_EDGE>

# Lancement des tests
cd wordcount
./run-tests.sh
```

---

## Tests de Performance

Trois configurations testées sur Shakespeare complet (5.3 MB) :

| Configuration | Cores | Temps | Speedup |
|--------------|-------|-------|---------|
| 1 executor × 1 core | 1 | 19.56s | 1.00x |
| 2 executors × 1 core | 2 | 18.94s | 1.03x |
| 2 executors × 2 cores | 4 | 11.91s | 1.64x |

**Résultats** :
- 59,508 mots uniques identifiés
- Mot le plus fréquent : "the" (27,549 occurrences)
- Speedup limité par Loi d'Amdahl (~40% code séquentiel)

Voir `RESULTS.md` pour l'analyse complète.

---

## Structure du Projet
```
spark-gcp-automation/
├── terraform/           # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── ansible/            # Configuration Management
│   ├── inventory/
│   ├── playbooks/
│   └── update-inventory.sh
├── wordcount/          # Application de test
│   └── wordcount.py
├── RESULTS.md          # Résultats des tests
└── README.md
```

---

## Technologies

| Composant | Technologie | Version |
|-----------|-------------|---------|
| Cloud Provider | Google Cloud Platform | - |
| Infrastructure | Terraform | 1.6.0 |
| Configuration | Ansible | 2.9 |
| Big Data | Apache Spark | 3.5.0 |
| OS | Ubuntu Server | 22.04 LTS |
| Compute | GCP e2-medium | 2 vCPU, 4GB RAM |

---

## Configuration GCP

**Projet** : spark-automation-tp-482009  
**Région** : europe-west1 (Belgique)  
**Zone** : europe-west1-b  
**Type machine** : e2-medium (2 vCPU, 4GB RAM)

**Coût estimé** : ~15€/mois (couvert par crédits gratuits)

---

## Résolution de Problèmes

### Ansible sur Windows
Ansible ne fonctionne pas nativement sur Windows. Utiliser WSL2 :
```bash
wsl --install -d Ubuntu
sudo apt update && sudo apt install -y ansible
```

### IPs publiques changent
Les IPs publiques GCP sont éphémères. Utiliser `update-inventory.sh` :
```bash
cd ansible
./update-inventory.sh
```

### Services Spark arrêtés
Après redémarrage des VMs, relancer manuellement :
```bash
# Sur le master
/opt/spark/sbin/start-master.sh

# Sur chaque worker
/opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077
```

---

## Nettoyage

**Important** : Détruire l'infrastructure après utilisation
```bash
cd terraform
terraform destroy
```

---

## Concepts Clés

**Infrastructure as Code (IaC)** : Gestion de l'infrastructure par du code versionné plutôt que par interface graphique.

**Terraform** : Outil IaC pour créer/modifier/détruire l'infrastructure cloud.

**Ansible** : Outil de configuration management pour installer et configurer des logiciels sur les machines.

**Apache Spark** : Framework de traitement distribué de données massives.

---

## Références

- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [Apache Spark](https://spark.apache.org/docs/latest/)

---

## Licence

Projet académique - Décembre 2025
