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

```
kubectl port-forward svc/tackle-ui 8080:8080 -n konveyor-tackle
# Access the UI at http://localhost:8080
```


### Important Notes

* Ensure you have at least 8GB RAM and 40GB disk space available
* The installation process may take 10-15 minutes depending on your internet connection
* Keep the port-forward command running to access the UI

# Spring PetClinic Modernisation 

### Deploy PetClinic with Konveyor Tackle

* Step 1: Prepare Source Code

```angular2html
# Clone the Spring PetClinic repository
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic

# Build the application to ensure it works
./mvnw clean package -DskipTests

# Create a ZIP file for upload to Konveyor
zip -r petclinic-source.zip . -x '*.git*' 'target/*'
```

* Step 2: Upload to Konveyor

```angular2html
# Access Konveyor UI (ensure port-forward is running)
kubectl port-forward svc/tackle-ui 8080:8080 -n konveyor-tackle

# Open browser to http://localhost:8080
# Navigate to Applications -> Create Application
# Upload petclinic-source.zip
```

* Step 3: Run Analysis

```
# In Konveyor UI:
# 1. Go to Analysis -> Create Analysis
# 2. Select 'Spring PetClinic' application
# 3. Choose target: 'Containerization' and 'Kubernetes'
# 4. Select rules: 'Spring Boot to Quarkus' (optional)
# 5. Click 'Run Analysis'

# Monitor analysis progress
kubectl logs -l app=tackle-analyzer -n konveyor-tackle -f
```

* Build Container Image

The [Dockerfile](./Dockerfile) is here 

* Deploy to Kubernetes

```angular2html
# Deploy to Kubernetes
kubectl apply -f petclinic-deployment.yaml

# Check deployment status
kubectl get pods -l app=petclinic
kubectl get svc petclinic-service
```

Access the application

```
# Get the service URL
minikube service petclinic-service --url

# Or use port forwarding
kubectl port-forward svc/petclinic-service 8080:8080

# Access the application
# Open browser to the provided URL or http://localhost:8080
```













