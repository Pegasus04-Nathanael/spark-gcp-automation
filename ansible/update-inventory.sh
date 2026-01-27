#!/bin/bash
# Script pour mettre à jour automatiquement hosts.ini

echo "🔄 Récupération des nouvelles IPs..."

MASTER_IP=$(gcloud compute instances describe spark-master --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
WORKER1_IP=$(gcloud compute instances describe spark-worker-1 --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
WORKER2_IP=$(gcloud compute instances describe spark-worker-2 --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
EDGE_IP=$(gcloud compute instances describe spark-edge --zone=europe-west1-b --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

echo "✅ IPs récupérées :"
echo "  Master: $MASTER_IP"
echo "  Worker-1: $WORKER1_IP"
echo "  Worker-2: $WORKER2_IP"
echo "  Edge: $EDGE_IP"

# Nettoie les anciennes entrées SSH
echo "🧹 Nettoyage des anciennes clés SSH..."
rm -f ~/.ssh/known_hosts
touch ~/.ssh/known_hosts

cat > inventory/hosts.ini << EOI
[spark_master]
spark-master ansible_host=$MASTER_IP ansible_user=spark ansible_ssh_private_key_file=~/.ssh/id_rsa

[spark_workers]
spark-worker-1 ansible_host=$WORKER1_IP ansible_user=spark ansible_ssh_private_key_file=~/.ssh/id_rsa
spark-worker-2 ansible_host=$WORKER2_IP ansible_user=spark ansible_ssh_private_key_file=~/.ssh/id_rsa

[spark_edge]
spark-edge ansible_host=$EDGE_IP ansible_user=spark ansible_ssh_private_key_file=~/.ssh/id_rsa

[all:children]
spark_master
spark_workers
spark_edge
EOI

echo "✅ hosts.ini mis à jour !"
echo "✅ known_hosts nettoyé !"
echo ""
echo "👉 Lance maintenant : ansible -i inventory/hosts.ini all -m ping"
