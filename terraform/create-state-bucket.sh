#!/bin/bash
# Création du bucket pour Terraform state

PROJECT_ID="spark-automation-tp-482009"
BUCKET_NAME="spark-terraform-state-${PROJECT_ID}"

# Crée le bucket
gcloud storage buckets create gs://${BUCKET_NAME} \
  --project=${PROJECT_ID} \
  --location=europe-west1 \
  --uniform-bucket-level-access

# Active le versioning (historique)
gcloud storage buckets update gs://${BUCKET_NAME} --versioning

echo "✅ Bucket créé : gs://${BUCKET_NAME}"
