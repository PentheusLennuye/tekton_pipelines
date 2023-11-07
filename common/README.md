# Common Code

## Directory Structures

```text
|- base
|  | - eventlisteners
|  | - tasks
|  | - pipelines
|  '
|- overlays
|  |- develop
|  |  |- kustomization.yaml
|  |- production
|  |  |- kustomization.yaml
|  |- staging
|  |  |- kustomization.yaml
'  '  '
```

## To apply

### Development Environment

```sh
kubectl apply -k overlays/development
```

### Staging Environment

```sh
kubectl apply -k overlays/staging
```

### Production Environment

```sh
kubectl apply -k overlays/production
```

## Reference

To see the POST from a Github webhook, read
<https://docs.github.com/en/webhooks/webhook-events-and-payloads#pull_request>

