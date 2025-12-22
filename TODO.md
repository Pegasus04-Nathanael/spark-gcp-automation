# 📋 TODO - Ordre des Sessions

## ✅ Session 1 - Infrastructure (COMPLÉTÉ)
- [x] Setup GCP project avec facturation
- [x] Installation Terraform + gcloud CLI
- [x] Installation Ansible (structure prête)
- [x] Création clés SSH
- [x] Code Terraform complet (VPC, VMs, Firewall)
- [x] Déploiement infrastructure sur GCP
- [x] Test connexion SSH
- [x] Documentation README
- [x] Push sur GitHub
- [x] Ajout collaborateur

---

## 🔄 Session 2 - Configuration Ansible (PRIORITAIRE)

### Prérequis
- [ ] Fixer Ansible sur Windows (installer via WSL2)
- [ ] Tester `ansible -m ping` sur toutes les VMs

### Développement Playbooks
- [ ] **Playbook common** (toutes les VMs)
  - [ ] Update système (apt update/upgrade)
  - [ ] Installation Java 11
  - [ ] Installation Python 3
  - [ ] Configuration timezone/locale
  
- [ ] **Playbook spark-master**
  - [ ] Télécharger Spark 3.5.0
  - [ ] Extraire dans /opt/spark
  - [ ] Configurer spark-env.sh (SPARK_MASTER_HOST)
  - [ ] Configurer spark-defaults.conf
  - [ ] Démarrer service Master : `start-master.sh`
  - [ ] Vérifier Web UI : http://MASTER_IP:8080

- [ ] **Playbook spark-workers**
  - [ ] Télécharger et installer Spark
  - [ ] Configurer connexion au Master
  - [ ] Démarrer workers : `start-worker.sh spark://MASTER_IP:7077`
  - [ ] Vérifier dans Master UI que workers sont connectés

- [ ] **Playbook spark-edge**
  - [ ] Installer Spark en mode client
  - [ ] Configurer spark-submit
  - [ ] Créer utilisateur pour jobs

### Tests
- [ ] Lancer tous les playbooks
- [ ] Vérifier logs des services
- [ ] Accéder Web UI Master (port 8080)
- [ ] Confirmer 2 workers actifs

---

## 📊 Session 3 - Application WordCount

### Développement
- [ ] Créer l'application WordCount en Scala ou Python
- [ ] Préparer un fichier texte de test (quelques MB)
- [ ] Upload fichier sur le cluster (HDFS ou local)

### Tests de Performance
- [ ] **Test 1** : 1 executor
  - [ ] Lancer WordCount
  - [ ] Noter le temps d'exécution
  - [ ] Screenshot des logs
  
- [ ] **Test 2** : 2 executors
  - [ ] Relancer avec 2 executors
  - [ ] Comparer les performances
  
- [ ] **Test 3** : 4 executors (si possible)
  - [ ] Test avec ressources max
  - [ ] Analyser scalabilité

### Métriques à Collecter
- [ ] Temps d'exécution total
- [ ] Nombre de tâches
- [ ] Utilisation CPU/Mémoire
- [ ] Screenshots Spark UI

---

## 📝 Session 4 - Documentation Finale

### Rapport (3 pages)
- [ ] **Introduction** (0.5 page)
  - [ ] Contexte du projet
  - [ ] Objectifs
  - [ ] Technologies choisies

- [ ] **Architecture** (1 page)
  - [ ] Schéma de l'infrastructure
  - [ ] Description des composants
  - [ ] Configuration réseau
  - [ ] Sécurité

- [ ] **Méthodologie** (0.5 page)
  - [ ] Terraform : IaC approach
  - [ ] Ansible : Configuration management
  - [ ] Process de déploiement

- [ ] **Résultats Tests** (0.75 page)
  - [ ] Résultats WordCount
  - [ ] Tableaux comparatifs
  - [ ] Graphiques de performance

- [ ] **Conclusions** (0.25 page)
  - [ ] Bilan technique
  - [ ] Difficultés rencontrées
  - [ ] Améliorations possibles

### Démo Live
- [ ] Préparer script de démo (10-15 min)
- [ ] Tester le flow complet
- [ ] Préparer slides si besoin

### Finitions
- [ ] Vérifier que tout est sur GitHub
- [ ] Screenshots dans /docs
- [ ] README à jour
- [ ] Code commenté

---

## 🚨 Avant Rendu Final

- [ ] `terraform destroy` pour nettoyer GCP
- [ ] Vérifier que le repo est bien privé
- [ ] Tous les fichiers sensibles dans .gitignore
- [ ] Aucune clé SSH ou credential committé
- [ ] README propre et complet
- [ ] Rapport PDF généré

---

## 💡 Idées d'Améliorations (Bonus)

- [ ] Monitoring avec Prometheus/Grafana
- [ ] Automatisation CI/CD avec GitHub Actions
- [ ] Support multi-région
- [ ] Auto-scaling des workers
- [ ] Utilisation de GCS (Google Cloud Storage) au lieu de local
- [ ] Terraform modules réutilisables
- [ ] Tests automatisés avec Terratest
- [ ] Documentation avec MkDocs

---

## 📞 Contacts

**Nathanael FETUE** - [nathanaelfetue1237@gmail.com/Pegasus04-Nathanael]  
**Romero TCHIAZE** - [email/GitHub]