cat > TODO.md << 'EOF'
# TODO - Spark GCP Automation

**Étudiants:** Nathanael FETUE & Romero TCHIAZE  
**Dernière mise à jour:** 18 janvier 2026

---

## PROGRESSION: 100%
```
[████████████████████████████████] 100%
Infrastructure ████████████ 100%
Ansible       ████████████ 100%
Cluster Spark ████████████ 100%
WordCount     ████████████ 100%
Rapport       ████████████ 100%
```

---

## SESSION 1 - Infrastructure (22 décembre 2025)

**Durée:** 3h | **Environnement:** Windows (GitBash)

- Infrastructure Terraform déployée (4 VMs, VPC, Firewall)
- GitHub repo créé et configuré
- Documentation initiale

---

## SESSION 2 & 3 - Ansible + Cluster (2 janvier 2026)

**Durée:** 2h30 | **Environnement:** GitHub Codespaces

- Configuration Ansible complète
- Spark 3.5.0 installé sur toutes les VMs
- Cluster opérationnel avec 2 Workers
- Test SparkPi réussi

---

## SESSION 4 - Tests WordCount (18 janvier 2026)

**Durée:** 2h | **Environnement:** GitHub Codespaces

### Réalisations
- Script wordcount.py créé et testé
- Fichier Shakespeare (5.2 MB, 196K lignes) utilisé
- 3 tests de performance effectués
- Script start-cluster.sh créé pour redémarrage rapide

### Résultats
| Test | Config | Temps | Speedup |
|------|--------|-------|---------|
| 1 | 1 exec × 1 core | 24.56s | 1.00x |
| 2 | 2 exec × 1 core | 22.92s | 1.07x |
| 3 | 2 exec × 2 cores | 15.73s | 1.56x |

### Corrections appliquées
- Workers redémarrés manuellement après reboot VMs
- Fichiers copiés dans /opt/spark/ pour accès distribué
- Inventaire Ansible mis à jour avec user codespace

---

## PROJET TERMINÉ

**Livrables:**
- Infrastructure Terraform fonctionnelle
- Configuration Ansible automatisée
- Cluster Spark 3.5.0 opérationnel
- Tests de performance documentés
- Script de redémarrage rapide
- Documentation complète

**Repository:** https://github.com/Pegasus04-Nathanael/spark-gcp-automation  
**GCP Project:** spark-automation-tp-482009

---

## Utilisation Future
```bash
# Redémarrer le cluster
./start-cluster.sh

# Lancer tests
ssh codespace@<EDGE_IP>
time /opt/spark/bin/spark-submit \
  --master spark://10.0.1.10:7077 \
  --executor-cores 2 --num-executors 2 \
  wordcount.py /opt/spark/input.txt results.txt

# Arrêter VMs (économiser)
gcloud compute instances stop spark-master spark-worker-1 \
  spark-worker-2 spark-edge --zone=europe-west1-b

# Détruire infrastructure
cd terraform && terraform destroy
```
EOF