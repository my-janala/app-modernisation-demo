# app-modernisation-demo

This project demonstrates application modernization using [Konveyor](https://konveyor.io/) on a local Kubernetes cluster with [minikube](https://minikube.sigs.k8s.io/).  
It includes step-by-step instructions for setting up Konveyor and modernizing Java applications, including the Spring PetClinic and a sample legacy Java application.

> **References followed:**  
> - [Konveyor Official Docs](https://konveyor.io/docs/konveyor/installation/)  
> - [Kube by Example: Install Konveyor and Analyze Legacy Java Application](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyze-legacy-java-application)  
> - [Konveyor Operator Installation (macOS)](https://github.com/konveyor/operator/blob/main/docs/installation-macos.md)

---

## Konveyor Installation Guide

_Follow these steps to set up Konveyor on minikube for application modernization._

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
minikube addons enable olm
```

If the OLM addon is not available or fails, install OLM manually:
```bash
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/install.yaml
```

---

### Install Konveyor Operator

```bash
kubectl create -f https://operatorhub.io/install/konveyor-operator.yaml
```

---

### Verify Operator Installation

```bash
# Check that the operator pod is running
kubectl get pods -n my-konveyor-operator

# Check that the Tackle CRD is installed
kubectl get crds | grep tackle
```
You should see a pod like `tackle-operator-xxxx` in the `Running` state and a CRD named `tackles.tackle.konveyor.io`.

---

### Deploy Tackle Custom Resource

```bash
cat <<EOF | kubectl apply -f -
apiVersion: tackle.konveyor.io/v1alpha1
kind: Tackle
metadata:
  name: tackle
  namespace: my-konveyor-operator
spec:
  feature_auth_required: false
EOF
```

---

### Verify Tackle Deployment

```bash
# Check that the Tackle custom resource exists
kubectl get tackle -n my-konveyor-operator

# Check that all pods are running
kubectl get pods -n my-konveyor-operator

# Check that the required services are available
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
kubectl port-forward svc/tackle-ui 8080:8080 -n my-konveyor-operator
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

---

# Analyzing a Legacy Java Application with Konveyor

This section demonstrates how to analyze a legacy Java application using Konveyor, following the ["Let's Get Started with Analysis Module"](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyze-legacy-java-application) guideline.  
_Note: In the latest Konveyor UI, analysis results may appear under the **Issues** tab rather than a dedicated Reports section._

## Step 1: Create an Application Entry in Konveyor

1. In the Konveyor UI, go to the **Analysis** tab and click **Create Application**.
2. Fill in the application details:
    - **Name:** `customer-tomcat`
3. Expand the **Source Code** section and enter the following:
    - **Repository Type:** `Git`
    - **Source Repository:** `https://github.com/konveyor/example-applications`
    - **Branch:** `main`
    - **Root path:** `/example-1/`
4. Click the **Create** button.

## Step 2: Run an Analysis

1. In the Konveyor UI, select the `customer-tomcat` application you just created.
2. Click **Analyze** (or **Create Analysis**).
3. Choose relevant targets (e.g., **Containerization**, **Kubernetes**).
4. (Optional) Select migration rules if applicable.
5. Click **Run Analysis**.
6. Monitor progress in the UI or with:
    ```bash
    kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f
    ```

## Step 3: Review Analysis Results

- After the analysis completes, go to your application's **Issues** tab in the Konveyor UI (not the Reports section).
- Review the list of issues and recommendations.

### Example Issues and How to Address Them

#### **1. File System - Java IO**

**Issue:**  
The application reads configuration from a file inside the container, e.g.:
```java
try (InputStream inputStream = new FileInputStream("/opt/config/persistence.properties")) {
    properties.load(inputStream);
}
```
**Why it's a problem:**  
- Container file systems are ephemeral; files may be lost on restart or redeploy.
- Hardcoded file paths make configuration updates difficult and less portable.

**How to modernize:**  
How you address this depends on the function of the file in local storage:

- **Logging:** Log to standard output and use a centralized log collector to analyze the logs.
- **Caching:** Use a cache backing service (such as Redis or Memcached) instead of writing cache data to the local file system.
- **Configuration:** Store configuration settings in environment variables or mount them into the container using Kubernetes ConfigMaps, so they can be updated without code changes.
- **Data storage:** Use a database backing service for relational data or a persistent data storage system, rather than writing to local files.
- **Temporary data storage:** Use the file system of a running container only for brief, single-transaction caches or temporary files that can be safely lost if the container restarts.
- Use **environment variables** for configuration, or mount configuration files using **Kubernetes ConfigMaps**.

**Example (ConfigMap as file):**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  persistence.properties: |
    key1=value1
    key2=value2
---
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
      - name: your-app
        volumeMounts:
        - name: config-volume
          mountPath: /opt/config
      volumes:
      - name: config-volume
        configMap:
          name: app-config
```
Or, refactor your Java code to read from environment variables.

---

#### **2. Hardcoded IP Address**

**Issue:**  
The application uses a hardcoded IP address in its configuration, e.g.:
```properties
jdbc.url=jdbc:oracle:thin:@169.60.225.216:1521/XEPDB1
```
**Why it's a problem:**  
- Hardcoded IPs make the app less portable and harder to move between environments.
- If the database IP changes, you must rebuild or manually edit your config.

**How to modernize:**  
- Use **environment variables** or **Kubernetes ConfigMaps/Secrets** for connection info.
- Reference your database by **Kubernetes Service DNS name** instead of an IP.

**Example:**
```properties
jdbc.url=jdbc:oracle:thin:@oracle-db-service:1521/XEPDB1
```
Where `oracle-db-service` is the name of your Kubernetes Service for the database.

---

## Summary Table

| Issue                | Why It’s a Problem                | Best Practice                                   |
|----------------------|-----------------------------------|-------------------------------------------------|
| File system Java IO  | Ephemeral storage, hard to update | Use env vars or ConfigMaps for configuration    |
| Hardcoded IP Address | Not portable, hard to maintain    | Use env vars/ConfigMaps, reference by DNS name  |

---

## Application Modernization Review Actions

When reviewing applications with Konveyor, you may be presented with several modernization strategy options. These are commonly referred to as the "5 Rs" of application modernization:

### **1. Rehost ("Lift and Shift")**
Move the application as-is from its current environment (such as on-premises or a VM) to a new infrastructure, typically the cloud or Kubernetes, with minimal or no code changes.  
**Use when:** You want a quick migration with minimal risk and effort, and the application is stable.

### **2. Replatform ("Lift, Tinker, and Shift")**
Move the application to a new platform, making minimal changes to leverage cloud or container features, but not altering the core architecture.  
**Use when:** You want to take advantage of new platform features (like managed databases or container orchestration) with minimal code changes.

### **3. Refactor ("Re-architect")**
Make significant changes to the application’s code or architecture to improve maintainability, scalability, or performance, or to adopt cloud-native patterns.  
**Use when:** The application needs modernization to meet new business requirements or resolve technical debt (e.g., breaking up a monolith into microservices).

### **4. Repurchase ("Drop and Shop")**
Replace the existing application with a new, often SaaS-based, solution that provides similar or improved functionality.  
**Use when:** Maintaining or modernizing the current application is not cost-effective, and a commercial off-the-shelf (COTS) or SaaS solution meets business needs.

### **5. Retire**
Decommission the application because it is no longer needed or its functionality is duplicated elsewhere.  
**Use when:** The application is obsolete, unused, or redundant, and retiring it reduces costs and complexity.

---

| Action      | Description                                                                 | When to Use                                      |
|-------------|-----------------------------------------------------------------------------|--------------------------------------------------|
| Rehost      | Move as-is to new infrastructure                                            | Quick migration, minimal changes                  |
| Replatform  | Move with minimal changes to leverage new platform features                 | Gain platform benefits, minor tweaks              |
| Refactor    | Redesign or rewrite to improve or modernize                                 | Address technical debt, adopt new architectures   |
| Repurchase  | Replace with a new (often SaaS) solution                                    | COTS/SaaS meets needs better than custom code     |
| Retire      | Decommission the application                                                | App is obsolete, unused, or redundant             |

These actions help you choose the best modernization strategy for each application, balancing effort, risk, and business value.

---

## Troubleshooting

- Ensure all pods in the `my-konveyor-operator` namespace are running.
- If you encounter issues, check logs with:
  ```bash
  kubectl logs <pod-name> -n my-konveyor-operator
  ```
- For more help, see the [Konveyor documentation](https://konveyor.github.io/tackle2-operator/).

---

## References

- [Konveyor Tackle2 Operator](https://github.com/konveyor/tackle2-operator)
- [Spring PetClinic](https://github.com/spring-projects/spring-petclinic)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Konveyor Official Docs](https://konveyor.io/docs/konveyor/installation/)
- [Kube by Example: Install Konveyor and Analyze Legacy Java Application](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyze-legacy-java-application)













