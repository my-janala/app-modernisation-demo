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
# 1. Start minikube with enough resources
minikube start --cpus=4 --memory=8192 --disk-size=40g -p konveyor-demo

# 2. Enable ingress and OLM addons (OLM is optional if you install it manually)
minikube addons enable ingress
minikube addons enable olm

# 3. (If OLM addon is not available or fails, install OLM manually)
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/install.yaml

# 4. Install the Konveyor operator from OperatorHub
kubectl create -f https://operatorhub.io/install/konveyor-operator.yaml

# 5. Wait for the operator pod to be running
kubectl get pods -n my-konveyor-operator

# 6. Create the Tackle custom resource
cat <<EOF | kubectl apply -f -
apiVersion: tackle.konveyor.io/v1alpha1
kind: Tackle
metadata:
  name: tackle
  namespace: my-konveyor-operator
spec:
  feature_auth_required: false
EOF

# 7. Wait for all Tackle pods to be running
kubectl get pods -n my-konveyor-operator

# 8. Port-forward the UI and access it in your browser
kubectl port-forward service/tackle-ui 8080:8080 -n my-konveyor-operator
# Then open http://localhost:8080
```

---

### Verify Installation


```bash
# Check that the Tackle custom resource exists in your operator namespace
kubectl get tackle -n my-konveyor-operator

# Check that all pods are running in your operator namespace
kubectl get pods -n my-konveyor-operator

# Check that the required services are available in your operator namespace
kubectl get svc -n my-konveyor-operator
```

You should see:
- A `tackle` resource listed.
- All pods (`tackle-operator`, `tackle-ui`, `tackle-hub`, etc.) in the `Running` state.
- Services `tackle-ui` and `tackle-hub` available.

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

## Cleanup

If you want to remove all Konveyor resources and your minikube cluster to free up system resources or start fresh, follow these steps:

```bash
# 1. Delete the Tackle custom resource (optional)
kubectl delete tackle tackle -n my-konveyor-operator

# 2. Delete the Konveyor operator and its namespace
kubectl delete namespace my-konveyor-operator

# 3. (If you created a separate konveyor-tackle namespace, delete it as well)
kubectl delete namespace konveyor-tackle

# 4. Delete the OLM (Operator Lifecycle Manager) components (optional)
kubectl delete -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/install.yaml

# 5. Delete the entire minikube cluster (this removes all workloads and data)
minikube delete -p konveyor-demo

# 6. (Optional) Delete all minikube clusters on your system
minikube delete --all
```

> **Note:** Deleting the minikube cluster will remove all applications, namespaces, and persistent data associated with that cluster.

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













