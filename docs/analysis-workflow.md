# Konveyor Administration Setup Checklist

Before starting application analysis, ensure the following administration tasks are completed in Konveyor:

- **User Roles & Permissions:** Confirm you have the necessary access to import, analyze, and manage applications.
- **Integrations:** Set up any required integrations (source code repositories, authentication, external tools).
- **Business Rules & Tags:** Configure custom rules, tags, or categories for organizing your analysis.
- **Analysis Settings:** Review and adjust default rulesets, migration targets, or inventory sources as needed.
- **System Health:** Check for pending upgrades, errors, or misconfigurations in the environment.

Completing these steps ensures a smooth and accurate analysis workflow.

# Analysis Workflow

Walk through a full analysis of the legacy Tomcat application using Konveyor / Migration Toolkit for Applications (MTA).

## Prerequisites

- A running Konveyor instance (see [Setup Guide](setup.md)).
- Access to the Konveyor UI.
- Optional: the sample application export at `assets/application-export.json`.

## Import or Create the Application

### Option A: Import the Sample Export

1. Open **Analysis → Applications** in the Konveyor UI.
2. Click **Import** and upload `assets/application-export.json`.
3. Confirm the application appears as `customer-tomcat` and proceed to run an analysis.

### Option B: Create the Application Manually

1. Navigate to the **Analysis** tab and click **Create Application**.
2. Populate the form:
   - **Name:** `customer-tomcat`
   - **Repository Type:** `Git`
   - **Source Repository:** `https://github.com/konveyor/example-applications`
   - **Branch:** `main`
   - **Root path:** `example-1/` (relative path)
3. Save the application.

## Run an Analysis

1. Select the `customer-tomcat` application.
2. Click **Analyse** (or **Create Analysis**).
3. Choose analysis targets such as **Containerisation** and **Kubernetes**.
4. (Optional) Add custom migration rules.
5. Launch the analysis and monitor progress from the UI or via:
   ```bash
   kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f
   ```

## Review Findings

Once the analysis completes, open the application's **Issues** tab.

### Typical Issues

#### 1. File System - Java IO

```java
try (InputStream inputStream = new FileInputStream("/opt/config/persistence.properties")) {
    properties.load(inputStream);
}
```

- **Why it matters:** Containers provide ephemeral storage; local files disappear on restart and hardcoded paths complicate configuration updates.
- **Modernisation approach:**
  - Move configuration to environment variables or mount files with ConfigMaps.
  - Redirect logging to stdout/stderr and rely on a central collector.
  - Swap file-based caches for managed services (Redis, Memcached).
  - Use databases or persistent volumes for durable data.

##### ConfigMap Example

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

#### 2. Hardcoded IP Address

```properties
jdbc.url=jdbc:oracle:thin:@169.60.225.216:1521/XEPDB1
```

- **Why it matters:** Hardcoded endpoints break portability; any IP change requires image rebuilds.
- **Modernisation approach:**
  - Store connection details in environment variables, ConfigMaps, or Secrets.
  - Refer to backing services by DNS names (e.g., Kubernetes Service).

##### Improved Configuration

```properties
jdbc.url=jdbc:oracle:thin:@oracle-db-service:1521/XEPDB1
```

### Summary

| Issue                | Why it’s a problem                | Best practice                                   |
|----------------------|-----------------------------------|-------------------------------------------------|
| File system Java IO  | Ephemeral storage, hard to update | Use env vars or ConfigMaps for configuration    |
| Hardcoded IP Address | Not portable, hard to maintain    | Use env vars/ConfigMaps, reference by DNS name  |

## Next Actions

Review the [Modernisation Playbook](modernisation-playbook.md) to plan remediation work, containerisation, and migration paths following the analysis.
