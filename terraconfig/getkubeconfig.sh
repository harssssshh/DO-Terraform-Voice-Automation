CLUSTER_ID=$(terraform output cluster-id)
OUTFILE="config"
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${TF_VAR_DO_TOKEN}" "https://api.digitalocean.com/v2/kubernetes/clusters/$CLUSTER_ID/kubeconfig" > $OUTFILE
cp config /tmp

