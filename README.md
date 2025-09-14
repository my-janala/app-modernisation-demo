# app-modernisation-demo

This project demonstrates application modernization using [Konveyor](https://konveyor.io/) on a local Kubernetes cluster with [minikube](https://minikube.sigs.k8s.io/). It includes step-by-step instructions for setting up Konveyor and modernizing the Spring PetClinic application.

---

## Konveyor Installation Guide

Follow these steps to set up Konveyor on minikube for application modernization.

### Prerequisites

- **Docker**: For building and running containers  
  [Install Docker for Mac](https://docs.docker.com/desktop/install/mac/)
- **minikube**: For running a local Kubernetes cluster  
  [Install minikube](https://minikube.sigs.k8s.io/docs/start/)
- **kubectl**: For interacting with Kubernetes  
  [Install kubectl](https://kubernetes.io/docs/tasks/tools/)

#### Quick Install Commands (for Apple Silicon)

```bash
# Install minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
sudo install -o root -g wheel -m 0755 kubectl /usr/local/bin/kubectl
```

> **Note:** Adjust the download URLs if you are using Intel-based Macs or Linux.

---

### Start Minikube

Initialize a minikube cluster with sufficient resources:

```bash
minikube start --cpus=4 --memory=8192 --disk-size=40g -p konveyor-demo
minikube addons enable ingress
kubectl get nodes
```

Check your minikube profile:

```bash
minikube profile list
```

---

### Install Konveyor Operator

```bash
kubectl create namespace konveyor-tackle
kubectl apply -f https://raw.githubusercontent.com/konveyor/tackle2-operator/main/tackle-k8s.yaml
kubectl get pods -n konveyor-tackle
```

---

### Deploy Tackle Custom Resource

```bash
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

---

### Verify Installation

```bash
kubectl get tackle -n konveyor-tackle
kubectl get pods -n konveyor-tackle
kubectl get svc -n konveyor-tackle
```

---

### Access the Konveyor UI

Set up port forwarding to access the UI:

```bash
kubectl port-forward svc/tackle-ui 8080:8080 -n konveyor-tackle
```

Open your browser and navigate to [http://localhost:8080](http://localhost:8080).

---

### Important Notes

- Ensure you have at least **8GB RAM** and **40GB disk space** available.
- The installation process may take **10-15 minutes** depending on your internet connection.
- Keep the port-forward command running to access the UI.

---

# Spring PetClinic Modernisation

## Deploy PetClinic with Konveyor Tackle

### Step 1: Prepare Source Code

```bash
# Clone the Spring PetClinic repository
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic

# Build the application to ensure it works
./mvnw clean package -DskipTests

# Create a ZIP file for upload to Konveyor
zip -r petclinic-source.zip . -x '*.git*' 'target/*'
```

---

### Step 2: Upload to Konveyor

- Ensure port-forwarding is running (`kubectl port-forward svc/tackle-ui 8080:8080 -n konveyor-tackle`)
- Open [http://localhost:8080](http://localhost:8080)
- Navigate to **Applications → Create Application**
- Upload `petclinic-source.zip`

---

### Step 3: Run Analysis

- In the Konveyor UI:
  1. Go to **Analysis → Create Analysis**
  2. Select the `Spring PetClinic` application
  3. Choose targets: **Containerization** and **Kubernetes**
  4. (Optional) Select rules: **Spring Boot to Quarkus**
  5. Click **Run Analysis**

Monitor analysis progress:

```bash
kubectl logs -l app=tackle-analyzer -n konveyor-tackle -f
```

---

### Step 4: Build Container Image

A sample [Dockerfile](./Dockerfile) is provided in this repository. Build your image as needed.

---

### Step 5: Deploy to Kubernetes

```bash
kubectl apply -f petclinic-deployment.yaml

# Check deployment status
kubectl get pods -l app=petclinic
kubectl get svc petclinic-service
```

---

### Step 6: Access the Application

```bash
# Get the service URL
minikube service petclinic-service --url

# Or use port forwarding
kubectl port-forward svc/petclinic-service 8080:8080

# Then open http://localhost:8080 in your browser
```

---

## Troubleshooting

- Ensure all pods in the `konveyor-tackle` namespace are running.
- If you encounter issues, check logs with:
  ```bash
  kubectl logs <pod-name> -n konveyor-tackle
  ```
- For more help, see the [Konveyor documentation](https://konveyor.github.io/tackle2-operator/).

---

## References

- [Konveyor Tackle2 Operator](https://github.com/konveyor/tackle2-operator)
- [Spring PetClinic](https://github.com/spring-projects/spring-petclinic)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)













