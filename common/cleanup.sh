#!/usr/bin/sh
# Cleaning Up
# Before shutting down K8S, lose the old pods

kubectl delete -k overlays/develop
