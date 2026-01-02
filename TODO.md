# 📋 TODO - Spark GCP Automation

**Étudiants :** Nathanael FETUE & Romero TCHIAZE  
**Deadline :** Décembre 2025  
**Dernière mise à jour :** 2 janvier 2026

---

## 📊 PROGRESSION : 85%
```
[████████████████████████████░░░░░] 85%
Infrastructure ████████████ 100%
Ansible       ████████████ 100%
Cluster Spark ████████████ 100%
WordCount     ░░░░░░░░░░░░   0%
Rapport       ░░░░░░░░░░░░   0%
```

---

## ✅ SESSION 1 - Infrastructure (22 décembre 2025)

**Durée :** 3h | **Environnement :** Windows (GitBash)

### Réalisations
- ✅ Setup GCP project `spark-automation-tp-482009`
- ✅ Configuration facturation (300€ crédits)
- ✅ Installation Terraform 1.6.0 + gcloud CLI
- ✅ Code Terraform complet :
  - VPC custom + Subnet (10.0.1.0/24)
  - 3 règles Firewall
  - 4 VMs Ubuntu 22.04 (master, 2 workers, edge)
- ✅ Déploiement réussi (9 ressources)
- ✅ Test SSH : connexion OK
- ✅ GitHub repo créé + Romero ajouté
- ✅ README.md + documentation

**Résultat :** Infrastructure complète sur GCP ✅

---

## ✅ SESSION 2 & 3 - Ansible + Cluster Spark (2 janvier 2026)

**Durée :** 2h30 | **Environnement :** GitHub Codespaces

### Setup
- ✅ Codespaces configuré (gcloud, Terraform, Ansible)
- ✅ Clé SSH générée et ajoutée aux VMs
- ✅ Connexion SSH validée : 4/4 VMs OK
- ✅ Ansible connectivity : 4/4 ping SUCCESS

### Playbooks Ansible
- ✅ `common.yml` : Java 11 + Python3 + wget installés
- ✅ `spark-install.yml` : Spark 3.5.0 téléchargé et installé
- ✅ `spark-master.yml` : Master configuré et démarré
- ✅ `spark-workers.yml` : 2 Workers connectés
- ✅ `spark-edge.yml` : Edge configuré
- ✅ `spark-setup.yml` : Orchestration complète (playbook maître)

### Cluster Opérationnel
- ✅ Master Web UI : http://35.205.230.69:8080
- ✅ 2 Workers actifs (10.0.1.11, 10.0.1.12)
- ✅ Ressources : 4 cores, ~2GB RAM

### Test SparkPi
- ✅ Job exécuté depuis Edge
- ✅ Résultat : **Pi ≈ 3.14244**
- ✅ 100 tâches distribuées sur 2 workers
- ✅ Temps : 8.8 secondes

**Résultat :** CLUSTER SPARK COMPLET ET FONCTIONNEL ! 🎉

---

## 🔄 SESSION 4 - WordCount (À VENIR)

**Durée estimée :** 1h30

### Tâches
- [ ] Créer script `wordcount.py`
- [ ] Télécharger fichier texte test (~10MB)
- [ ] Upload sur spark-edge

### Tests Performance
- [ ] **Test 1** : 1 executor
  - Lancer WordCount
  - Noter temps d'exécution
  - Screenshot
  
- [ ] **Test 2** : 2 executors
  - Relancer
  - Comparer performances
  
- [ ] **Test 3** : 4 executors (max ressources)
  - Analyser scalabilité

### Métriques
- [ ] Tableau comparatif (temps, speedup)
- [ ] Screenshots Web UI
- [ ] Logs et résultats

### Git
- [ ] Commit wordcount.py
- [ ] Commit résultats tests
- [ ] Push sur GitHub

---

## 📝 SESSION 5 - Rapport Final (À VENIR)

**Durée estimée :** 1h30  
**Format :** PDF, 3 pages

### Contenu
- [ ] **Page 1** : Introduction + Architecture (schéma réseau)
- [ ] **Page 2** : Méthodologie (Terraform + Ansible)
- [ ] **Page 3** : Tests WordCount + Résultats + Conclusions

### Livrables
- [ ] Rapport PDF exporté
- [ ] Script démo (15 min)
- [ ] Screenshots finaux dans /docs

---

## 🚨 AVANT RENDU FINAL

- [ ] `terraform destroy` pour nettoyer GCP
- [ ] Vérifier .gitignore (pas de secrets)
- [ ] README.md à jour
- [ ] Rapport PDF dans le repo
- [ ] Partager lien GitHub avec prof

---

## 📞 CONTACTS

**Nathanael FETUE**  
Email : nathanaelfetue1237@gmail.com  
GitHub : Pegasus04-Nathanael

**Romero TCHIAZE**  
Email : [à compléter]  
GitHub : [à compléter]

**Repository :** https://github.com/Pegasus04-Nathanael/spark-gcp-automation  
**GCP Project :** spark-automation-tp-482009
```

---

## 🎯 **DIFFÉRENCE CLEF**

**AVANT (mauvais) :**
- ✅ Fait
- [ ] À faire

→ On perd l'historique session par session

**MAINTENANT (bon) :**
```
✅ SESSION 1 - ce qu'on a fait
✅ SESSION 2 - ce qu'on a fait
✅ SESSION 3 - ce qu'on a fait
🔄 SESSION 4 - ce qu'on va faire
📝 SESSION 5 - ce qu'on va faire