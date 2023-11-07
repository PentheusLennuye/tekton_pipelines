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

## Concept of GitFlow

GitFlow is not necessarily the most efficient of the CI/CD processes. However,
it is considered less risky than merging straight into the main branch from
new features and bug fixes.

Each PR, push or merge (i.e. a closed PR with merge set to "true") triggers a
Tekton EventListener.

### Tasks

- GB: Git Branch Check: does the branch name conform to team standards?
- CL: Clone Code
- GF: GitFlow Check: is the head branch supposed to go into the base branch?
- CT: Code Tests: linting and unit testing
- CC: Compile Code: compile binaries
- CP: Create Container and Publish: Build a container and publish to a repo
- DC: Deploy Container: create a Kubernetes deployment and service. Set dynamic
      DNS.
- BC: Behaviour Checks. How is the end-to-end?
- DD: Destroy Deployment: free up resources as the test deployment and service
      is no longer required.
- TA: Tag Code and Container: Apply git and image tags and VERSION files to
      ensure code and container is properly versioned.

### Feature Development

1. A programmer creates a feature branch. The branch name must conform to the
   business rules. Each push requires the code to be clean.
   ```text
   Pipeline: GB -> CL -> CT
   ```
2. The programmer is happy with his or work and creates a pull request against
   the development branch. The system should fire up a test deployment as proof
   of effectiveness.
   ```text
   Pipeline: GB -> GF -> CL -> CT -> CC -> CP -> DC -> BC
   ```
3. The SRE is impressed with the feature and merges it into the development
   branch.
   ```text
   Pipeline: DD
   ```
4. Rinse and Repeat steps 1 through 3 until it is time to stage.


### Release to Production

1. The SRE creates a (say) release-1.5.0 branch from deployment branch and
   pushes it. The system creates a staging deployment for user acceptance,
   with perhaps different replicas than the feature and main environments.
   Note that this is _exactly_ the same pipeline as the feature -> development
   pull request. The container is tagged IMAGE-1.5.0-rc.
   ```text
   Pipeline: GB -> GF -> CL -> CT -> CC -> CP -> DC -> BC
   ```
2. Developers add a few more tweaks to the release branch using push. K8S
   images should be set to imagePullPolicy: Always to permit changes to be
   tested.
   ```text
   Pipeline: GB -> GF -> CL -> CT -> CC -> CP -> DC -> BC
   ```
3. The end user is happy! The SRE creates a PR to main from release
   ```text
   Pipeline: GB -> GF -> CL -> CT
   ```
4. The project owner or SRE merges release into main. The code is now tagged,
   with the version number, and the published container retagged to remove the
   -rc suffix. The staging deployment is removed to free resources.
   ```text
   Pipeline: GB -> TA -> DD
   ```
5. The SRE merges the main branch into the development branch.

### Hotfixes

Should a hotfix on main be required, repeat "Release to Production", but use
the branch name hotfix-1.5.1 rather than release-1.5.0.

## Design Decision

Most of the sequences above share tasks in the same order. There will be two
(2) pipelines:

- github-build-deploy
- github-tag-delete

Each task can be skipped, so as an example, a push to a feature branch can use
the same pipeline as a push request to release, without having to build and
deploy. The decision tree on which pipeline to use will be set in the Tekton
_EventListener_.

## To Apply

### Development Environment

```sh
kubectl apply -k overlays/develop
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

