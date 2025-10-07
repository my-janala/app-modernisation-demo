# Setup Guide

Follow this guide to provision a local Konveyor environment on Minikube and prepare runnable assets for the legacy Tomcat application.

## Prerequisites

- **Docker** – container runtime for building/running images.  
  [Install Docker for Mac](https://docs.docker.com/desktop/install/mac/)
- **minikube** – local Kubernetes cluster.  
  [Install minikube](https://minikube.sigs.k8s.io/docs/start/)
- **kubectl** – Kubernetes CLI.  
  [Install kubectl](https://kubernetes.io/docs/tasks/tools/)
- **Java 17 or later** (for building/running legacy workloads).  
  Check with:
  ```bash
  java -version
  ```

### Quick Install Commands (Apple Silicon)

```bash
# Install minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
sudo install -o root -g wheel -m 0755 kubectl /usr/local/bin/kubectl
```
> Adjust URLs if you use an Intel-based Mac or Linux.

## Automated Setup (Makefile)

This repository provides a `Makefile` that automates the full lifecycle. By default it relies on the Minikube `olm` addon, waits for the Konveyor operator to register its CRDs, and then creates the Tackle instance automatically:

```bash
# Provision Minikube, OLM, and Konveyor (defaults to profile "konveyor-demo")
make setup

# (Optional) expose the Konveyor UI on http://localhost:8080
make port-forward

# Remove Konveyor resources and delete the Minikube profile
make teardown
```

If the Minikube addon fails to provide a healthy catalog, rerun the setup with manual OLM installation enabled:

```bash
make INSTALL_OLM_MANUALLY=true setup
```

You can override resources with variables, for example:

```bash
make CPUS=6 MEMORY=12288 setup
```

The commands assume `kubectl` communicates with the created Minikube profile (context `konveyor-demo` by default).

## Manual Setup Steps

### Start Minikube

```bash
minikube start --cpus=4 --memory=8192 --disk-size=40g -p konveyor-demo
minikube addons enable ingress
minikube addons enable olm
```

If the OLM addon is unavailable—or you prefer to use the pinned manifests—disable it and apply the same release used by the automated flow:

```bash
minikube addons disable olm
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.25.0/crds.yaml
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.25.0/olm.yaml
```

### Install Konveyor Operator

```bash
kubectl create -f https://operatorhub.io/install/konveyor-operator.yaml
```

### Verify Operator Installation

```bash
# Check that the operator pod is running
kubectl get pods -n my-konveyor-operator

# Check that the Tackle CRD is installed
kubectl get crds | grep tackle
```

You should see a pod like `tackle-operator-xxxx` in the `Running` state and a CRD named `tackles.tackle.konveyor.io`.

### Deploy Tackle Custom Resource

```bash
cat <<'YAML' | kubectl apply -f -
apiVersion: tackle.konveyor.io/v1alpha1
kind: Tackle
metadata:
  name: tackle
  namespace: my-konveyor-operator
spec:
  feature_auth_required: false
YAML
```

### Verify Tackle Deployment

```bash
# Check that the Tackle custom resource exists
kubectl get tackle -n my-konveyor-operator

# Check that all pods are running
kubectl get pods -n my-konveyor-operator

# Check that the required services are available
kubectl get svc -n my-konveyor-operator
```

Expect to see:

- A `tackle` resource listed.
- Pods such as `tackle-operator`, `tackle-ui`, and `tackle-hub` in the `Running` state.
- Services `tackle-ui` and `tackle-hub` exposed.

### Access the Konveyor UI

```bash
kubectl port-forward svc/tackle-ui 8080:8080 -n my-konveyor-operator
```

Open your browser at [http://localhost:8080](http://localhost:8080).

## Important Notes

- Allocate at least **8GB RAM** and **40GB disk space** to Minikube.
- Installation can take **10–15 minutes** depending on network speed.
- Keep `kubectl port-forward` running to access the UI.

## Example Outputs

After a successful setup, you should observe output similar to:

```bash
$ kubectl get pods -n my-konveyor-operator
NAME                                           READY   STATUS    RESTARTS   AGE
konveyor-operator-controller-manager-6cb6547   1/1     Running   0          2m13s
tackle-hub-6f85778968-b6z7l                    1/1     Running   0          82s
tackle-operator-7f4b7c6d9c-gzv4s               1/1     Running   0          82s
tackle-ui-866c5f484d-5m8cs                     1/1     Running   0          82s
```

```bash
$ kubectl get tackle -n my-konveyor-operator
NAME     AGE   READY
tackle   78s   True
```

## Troubleshooting

- **Pods Pending:** If pods remain in `Pending`, run `kubectl describe pod <name> -n my-konveyor-operator`. Usually the node lacks resources—increase Minikube resources (`make MEMORY=12288 CPUS=6 setup`) or reclaim space by deleting unused namespaces.
- **OLM Catalog Image Pull Errors:** Failures mentioning `quay.io/operator-framework` typically indicate network or proxy issues. Re-run `make INSTALL_OLM_MANUALLY=true setup` after connectivity returns (or apply the pinned manifests manually), or pre-pull images with `minikube image pull` for offline use.
- **Analyzer Job Errors:** If analyses produce no results, list jobs with `kubectl get jobs -n my-konveyor-operator` and inspect logs using `kubectl logs job/<job-name> -n my-konveyor-operator --tail=100`. Confirm repository URL, branch, and root path values in the UI.
- **Tackle CR Creation Hangs:** `kubectl apply` may finish before deployments exist. Run `make wait-konveyor` to wait for `tackle-operator`, `tackle-ui`, and `tackle-hub` deployments to become `Available`.
- **General Diagnostics:** Use `kubectl logs <pod> -n my-konveyor-operator` and `kubectl get events -n my-konveyor-operator --sort-by=.lastTimestamp` to surface root causes. Refer to the [Konveyor documentation](https://konveyor.github.io/tackle2-operator/) for component-specific tips.

## Sample Assets

- `assets/application-export.json` – ready-to-import Konveyor application definition (repository, branch, and root path included). In the UI open **Analysis → Applications → Import**, upload the file, and launch an analysis immediately.
- `assets/configmap.yaml` – ConfigMap template that externalises key application properties.
- `assets/secret.yaml` – Secret skeleton for database credentials; update values before applying.
- `assets/deployment.yaml` – Deployment manifest that wires the ConfigMap and Secret into the Tomcat container image.

Quick start:

```bash
kubectl create namespace retail
kubectl apply -n retail -f assets/secret.yaml
kubectl apply -n retail -f assets/configmap.yaml
kubectl apply -n retail -f assets/deployment.yaml
```

Adjust the image reference or database settings for your environment, and add a `Service`/`Ingress` for external access if required.
