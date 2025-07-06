# app-modernisation-demo
app-modernisation-demo

### Konveyor Installation Guide

Follow these steps to set up Konveyor on minikube for application modernization.


#### Prerequisites Setup

- Install Docker, minikube, and kubectl

```angular2html
# Install Docker (if not already installed)
# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
# Install kubectl
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

- Start Minikube
Initialize minikube cluster with sufficient resources

```
minikube start --cpus=4 --memory=8192 --disk-size=40g
minikube addons enable ingress
kubectl get nodes
```

- Install Konveyor Operator

```
kubectl create namespace konveyor-tackle
kubectl apply -f https://raw.githubusercontent.com/konveyor/tackle2-operator/main/tackle-k8s.yaml
kubectl get pods -n konveyor-tackle
```

* Deploy Tackle CR
Create and apply the Tackle Custom Resource


```
cat <<EOF | kubectl apply -f -
apiVersion: tackle.konveyor.io/v1alpha1
kind: Tackle
metadata:
  name: tackle
  namespace: konveyor-tackle
spec:
  feature_auth_required: false
EOF
```

* Verify Installation
Check that all components are running

```
kubectl get tackle -n konveyor-tackle
kubectl get pods -n konveyor-tackle
kubectl get svc -n konveyor-tackle
```


* Access the UI
Set up port forwarding to access Konveyor UI

Terminal Commands

Copy
kubectl port-forward svc/tackle-ui 8080:8080 -n konveyor-tackle
# Access the UI at http://localhost:8080
Important Notes
•
Ensure you have at least 8GB RAM and 40GB disk space available
•
The installation process may take 10-15 minutes depending on your internet connection
•
Keep the port-forward command running to access the UI