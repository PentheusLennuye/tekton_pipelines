# Cards Pipeline

## Requirements

Ask your K8S administrator to create the appropriate ingress with the path
_/helloweb_  pointing to the k8s svc __el_github-helloweb__ port 8080 in
each environment.

## Directory Structures

```text
|- base
|  |- kustomization.yaml
|  |- eventlisteners
|  |- pipelines
|  |- tasks
'  '
|- overlays
|  |- develop
|  |  |- kustomization.yaml
|  |- production
|  |  |- kustomization.yaml
|  |- staging
|  |  |- kustomization.yaml
'  '  '

```

## Reference

To see the POST from a Github webhook, read
<https://docs.github.com/en/webhooks/webhook-events-and-payloads#pull_request>

