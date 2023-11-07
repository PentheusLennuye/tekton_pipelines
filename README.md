# Tekton Pipelines

Pipelines are kept separate from the code and environments that they manage.

## Directory Structures

```text
|- common
|  |- base
|  |  | - eventlisteners
|  |  | - tests
|  |  | - tasks
|  |  | - pipelines
|  |  '
|  |- overlays
|  |  |- develop
|  |  |  |- kustomization.yaml
|  |  |- production
|  |  |  |- kustomization.yaml
|  |  |- staging
|  |  |  |- kustomization.yaml
'  '  '  '
|- <other specific pipeline>
|  |- base
|  |  | - eventlisteners
|  |  | - tests
|  |  | - tasks
|  |  | - pipelines
|  |  '
|  |- overlays
|  |  |- develop
|  |  |  |- kustomization.yaml
|  |  |- production
|  |  |  |- kustomization.yaml
|  |  |- staging
|  |  |  |- kustomization.yaml
'  '  '  '
```
