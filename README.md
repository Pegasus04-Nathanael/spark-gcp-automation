# 🚀 Spark Cluster Automation on GCP

Automatisation du déploiement d'un cluster Apache Spark sur Google Cloud Platform avec Terraform et Ansible.

## 👥 Auteurs
- **Nathanael FETUE**
- **Romero TCHIAZE**

## 📅 Projet
Project Infrastructure Cloud - Big Data - Décembre 2025

---

## 🏗️ Architecture Déployée
```
VPC: spark-vpc (10.0.0.0/16)
│
└── Subnet: spark-subnet (10.0.1.0/24)
    │
    ├── spark-master (10.0.1.10) - Spark Master Node
    ├── spark-worker-1 (10.0.1.11) - Spark Worker Node
    ├── spark-worker-2 (10.0.1.12) - Spark Worker Node
    └── spark-edge (10.0.1.20) - Job Submission Node
```

### 🔒 Sécurité
- **Règles Firewall** : SSH (22), Spark Master UI (8080), Spark Communication (7077, 4040)
- **Authentification** : Clés SSH uniquement (pas de mot de passe)
- **Réseau** : VPC isolé avec communication interne complète
- **Accès** : IPs publiques pour connexion externe, IPs privées pour communication interne

---

## 📋 Prérequis

- **Google Cloud Platform** : Compte avec crédits actifs (300$ gratuits)
- **Terraform** : >= 1.6.0
- **Ansible** : >= 2.9 (via WSL2 sur Windows)
- **gcloud CLI** : Configuré et authentifié
- **Clé SSH** : Générée (~/.ssh/id_rsa)

---

## 🚀 Déploiement

### Phase 1 : Infrastructure Terraform (✅ COMPLÉTÉ)
```bash
cd terraform

# 1. Initialiser Terraform
terraform init

# 2. Vérifier le plan de déploiement
terraform plan

# 3. Déployer l'infrastructure
terraform apply
# Taper "yes" pour confirmer

# 4. Récupérer les IPs des VMs
terraform output
```

**Ressources créées :**
- ✅ 1 VPC custom (spark-vpc)
- ✅ 1 Subnet (10.0.1.0/24)
- ✅ 3 règles Firewall (SSH, Spark UI, communication interne)
- ✅ 4 Compute Engine instances :
  - spark-master (e2-medium, 50GB)
  - spark-worker-1 (e2-medium, 50GB)
  - spark-worker-2 (e2-medium, 50GB)
  - spark-edge (e2-medium, 30GB)

### Phase 2 : Configuration Ansible (🔄 EN COURS)
```bash
cd ansible

# 1. Tester la connectivité
ansible -i inventory/hosts.ini spark_cluster -m ping

# 2. Déployer la configuration Spark
ansible-playbook -i inventory/hosts.ini playbooks/spark-setup.yml
```

### Phase 3 : Tests et Validation (📅 À VENIR)

- Application WordCount pour valider le fonctionnement
- Tests de performance avec différents nombres d'executors
- Mesure et documentation des résultats

---

## 📁 Structure du Projet
```
spark-gcp-automation/
├── terraform/
│   ├── main.tf              # Définition infrastructure (VPC, VMs, Firewall)
│   ├── variables.tf         # Variables paramétrables
│   ├── outputs.tf           # Outputs (IPs publiques/privées)
│   └── terraform.tfvars     # Configuration du projet GCP
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini        # Inventaire des machines (IPs + groupes)
│   ├── playbooks/
│   │   └── spark-setup.yml  # Playbook de configuration Spark
│   └── roles/               # Rôles Ansible (à développer)
├── docs/
│   └── architecture.md      # Documentation détaillée
├── tests/
│   └── wordcount/           # Application de test WordCount
└── README.md                # Ce fichier
```

---

## 🔑 Connexion SSH aux VMs
```bash
# Master Node
ssh -i ~/.ssh/id_rsa spark@34.77.42.206

# Worker 1
ssh -i ~/.ssh/id_rsa spark@35.233.70.194

# Worker 2
ssh -i ~/.ssh/id_rsa spark@34.78.14.69

# Edge Node
ssh -i ~/.ssh/id_rsa spark@35.240.83.154
```

**Note :** Les IPs publiques ci-dessus sont des exemples. Utilisez `terraform output` pour obtenir les IPs réelles.

---

## 📊 État d'Avancement

| Phase | Statut | Détails |
|-------|--------|---------|
| ✅ Infrastructure Terraform | **Complété** | VPC, VMs, Firewall déployés sur GCP |
| 🔄 Configuration Ansible | **En cours** | Structure créée, playbooks à développer |
| 📅 Installation Spark | **À faire** | Configuration Master/Workers/Edge |
| 📅 Tests WordCount | **À faire** | Validation et benchmarks de performance |
| 📅 Documentation finale | **À faire** | Rapport technique de 3 pages |

---

## 💻 Technologies Utilisées

| Catégorie | Technologie | Version |
|-----------|-------------|---------|
| **Cloud** | Google Cloud Platform | - |
| **IaC** | Terraform | 1.6.0 |
| **Config Mgmt** | Ansible | 2.9+ |
| **Big Data** | Apache Spark | 3.5.0 (prévu) |
| **OS** | Ubuntu Server | 22.04 LTS |
| **Compute** | GCP e2-medium | 2 vCPU, 4GB RAM |

---

## 🔧 Configuration GCP

**Projet GCP :** `spark-automation-tp-482009`  
**Région :** `europe-west1` (Belgique)  
**Zone :** `europe-west1-b`  
**Machine Type :** `e2-medium` (2 vCPU, 4GB RAM)

**Coût estimé :** ~15€/mois (entièrement couvert par les 300€ de crédits gratuits)

---

## ⚠️ Résolution de Problèmes

### Ansible ne fonctionne pas sur Windows

**Problème :** `AttributeError: module 'os' has no attribute 'get_blocking'`

**Solution :** Utiliser WSL2 (Windows Subsystem for Linux)
```bash
# Dans PowerShell (Administrateur)
wsl --install -d Ubuntu

# Après redémarrage, dans Ubuntu
sudo apt update
sudo apt install -y ansible sshpass

# Vérifier l'installation
ansible --version
```

### Connexion SSH refusée
```bash
# Vérifier les permissions de la clé
chmod 600 ~/.ssh/id_rsa

# Tester la connexion
ssh -i ~/.ssh/id_rsa spark@IP_PUBLIQUE
```

### Erreur Terraform "project not found"
```bash
# Vérifier le project ID
gcloud config get-value project

# Reconfigurer si nécessaire
gcloud config set project spark-automation-tp-482009
```

---

## 📚 Ressources et Références

- [Documentation Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [GCP Compute Engine](https://cloud.google.com/compute/docs)

---

## 🗑️ Nettoyage

**⚠️ IMPORTANT : Détruire l'infrastructure après les tests pour éviter les coûts !**
```bash
cd terraform
terraform destroy
# Taper "yes" pour confirmer
```

Cela supprimera toutes les ressources GCP créées par Terraform.

---

## 📝 Prochaines Étapes

- [ ] Fixer Ansible sur Windows (WSL2)
- [ ] Développer les playbooks Ansible complets
- [ ] Installer et configurer Apache Spark sur toutes les VMs
- [ ] Créer l'application WordCount de test
- [ ] Exécuter les tests de performance
- [ ] Rédiger le rapport final (3 pages)
- [ ] Préparer la démo live

---

## 📄 Licence

Ce projet est réalisé dans le cadre d'un projet académique - Décembre 2025