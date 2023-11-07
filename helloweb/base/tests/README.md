# Pipelines and EventListeners

These are created through `k create -f`

Example:

```sh
PRUN=$(kubectl create -f pipelinerun_cards.yaml | cut -d'/' -f2 | awk '{print $1}') 
tkn pipelinerun logs $PRUN
```

After satisfied ...

```sh
k delete -n develop pipelinerun $PRUN
```
