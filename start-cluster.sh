#!/bin/bash
set -e

echo "🚀 Démarrage du cluster Spark..."

# 1. Démarre les VMs si arrêtées
echo "📦 Démarrage des VMs..."
gcloud compute instances start spark-master spark-worker-1 spark-worker-2 spark-edge \
  --zone=europe-west1-b 2>/dev/null || echo "VMs déjà démarrées"

# 2. Attend que les VMs soient prêtes
echo "⏳ Attente 60 secondes..."
sleep 60

# 3. Met à jour l'inventaire
echo "📝 Mise à jour inventaire Ansible..."
cd ansible
./update-inventory.sh

# 4. Récupère les IPs
MASTER_IP=$(gcloud compute instances describe spark-master --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
WORKER1_IP=$(gcloud compute instances describe spark-worker-1 --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
WORKER2_IP=$(gcloud compute instances describe spark-worker-2 --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
EDGE_IP=$(gcloud compute instances describe spark-edge --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

# 5. Redémarre les Workers
echo "🔧 Redémarrage Workers..."
ssh -o StrictHostKeyChecking=no codespace@$WORKER1_IP "sudo -u spark /opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077" &
ssh -o StrictHostKeyChecking=no codespace@$WORKER2_IP "sudo -u spark /opt/spark/sbin/start-worker.sh spark://10.0.1.10:7077" &
wait

echo ""
echo "✅ Cluster démarré !"
echo "📊 Web UI: http://$MASTER_IP:8080"
echo "🖥️  SSH Edge: ssh codespace@$EDGE_IP"
echo ""
