#!/usr/bin/sh
# Cleaning Up
# Before shutting down K8S, lose the old pods

kubectl delete pipelineruns -n develop -l triggers.tekton.dev/trigger=trigger-push
kubectl delete pipelineruns -n develop -l triggers.tekton.dev/trigger=trigger-pr
kubectl delete pipelineruns -n develop -l triggers.tekton.dev/trigger=trigger-merge
kubectl delete -k overlays/develop
kubectl get pv | grep develop-nfs-client | awk '{print $1}' | xargs kubectl delete pv
