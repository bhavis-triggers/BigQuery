#!/bin/bash
# add_replicas.sh
set -e  # Exit on any error

PROJECT="gleaming-nomad-474505-r3"
DATASET="replicadataset"

echo "Adding replicas to ${PROJECT}.${DATASET}..."

#gcloud auth list
# Add US-East4 replica
#bq query --project_id=$PROJECT --location=US "ALTER DATASET \`${PROJECT}.${DATASET}\` ADD REPLICA \`us_east4_replica\` OPTIONS(location='us-central1')"
bq query --use_legacy_sql=false 'ALTER SCHEMA `gleaming-nomad-474505-r3.replicadataset` ADD REPLICA `replica1` OPTIONS (location=us-central1)'
echo "✓ US-East4 replica added"

# Add Asia replica  
#bq query --location=US "ALTER DATASET \`${PROJECT}.${DATASET}\` ADD REPLICA \`asia_replica\` OPTIONS(location='asia-southeast1')"
#echo "✓ Asia replica added"

# Verify
bq show --format=prettyjson "${PROJECT}.${DATASET}" | jq '.replicas'
echo "✓ All replicas verified"
