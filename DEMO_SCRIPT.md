# Demo Script & Checklist

## Quick Demo Commands Reference

### Pre-Demo Setup (Run 30 mins before presentation)

```bash
# Verify environment
docker --version
minikube version  
kubectl version --client
java -version

# Test full workflow
make setup
make port-forward
# Open browser: http://localhost:8080
make teardown
```

## Live Demo Checklist

### Before Presentation
- [ ] Close unnecessary applications (free up RAM)
- [ ] Disable notifications and screen savers
- [ ] Open terminal with large font (16pt+)
- [ ] Have backup browser tabs ready
- [ ] Test internet connection
- [ ] Charge laptop and have power cable ready

### Demo Environment Setup

```bash
# Phase 1: Show clean state
echo "=== Starting with clean environment ==="
minikube status konveyor-demo 2>/dev/null || echo "✓ No existing cluster"

# Phase 2: One-command setup
echo "=== Setting up complete modernization platform ==="
time make setup

# Expected output to highlight:
# - Minikube starting with specified resources
# - OLM installation
# - Konveyor operator deployment
# - Waiting for pods to be ready
```

### Validation Commands

```bash
# Show what was created
echo "=== Kubernetes cluster ready ==="
kubectl get nodes
kubectl get namespaces | grep konveyor
kubectl get pods -n my-konveyor-operator

# Expected pods:
# - tackle-hub
# - tackle-ui  
# - tackle-operator
# - All should show "Running" status
```

### UI Access Setup

```bash
# Start port forwarding
echo "=== Exposing Konveyor UI ==="
make port-forward &
sleep 5
echo "UI available at: http://localhost:8080"

# Open browser (have this ready as bookmark)
open http://localhost:8080
```

## Browser Demo Flow

### 1. Konveyor UI Overview (2 minutes)
**URL:** `http://localhost:8080`

**Navigation Points:**
- Dashboard overview
- Applications tab (empty state)
- Administration section
- Analysis history

**Key Message:** "Enterprise-grade UI for application portfolio management"

### 2. Application Import (3 minutes)

**Method A - JSON Import (Recommended):**
```
Applications → Import → Upload File
File: assets/application-export.json
```

**Method B - Manual Creation:**
```
Applications → Create Application
Name: customer-tomcat
Repository Type: Git
URL: https://github.com/konveyor/example-applications
Branch: main
Root Path: example-1/
```

**Validation:** Application appears in list with tags (tomcat, legacy)

### 3. Analysis Configuration (2 minutes)

**Steps:**
1. Select "customer-tomcat" application
2. Click "Analyze" button
3. Choose analysis targets:
   - ✓ Containerization
   - ✓ Kubernetes
4. Click "Run Analysis"

**While Analysis Runs - Terminal Commands:**
```bash
# Show analysis in progress
kubectl get jobs -n my-konveyor-operator
kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f

# Expected: See analyzer processing files
```

### 4. Results Review (5-7 minutes)

**Navigation:** Applications → customer-tomcat → Issues tab

**Key Issues to Demonstrate:**

**Issue 1: File System Access**
```java
// Example code shown in UI
FileInputStream inputStream = new FileInputStream("/opt/config/persistence.properties");
```

**Explain:**
- Problem: Hardcoded paths, ephemeral storage
- Impact: Configuration management, data persistence  
- Solution: ConfigMaps and mounted volumes

**Issue 2: Hardcoded Network Configuration**
```properties
jdbc.url=jdbc:oracle:thin:@169.60.225.216:1521/XEPDB1
```

**Explain:**
- Problem: No portability, manual updates required
- Impact: Environment promotion, disaster recovery
- Solution: Environment variables and service discovery

## Asset Demonstration

### Show Modernized Kubernetes Resources

```bash
echo "=== Modern Kubernetes approach ==="

# ConfigMap for application properties
cat assets/configmap.yaml

# Secret for sensitive data
cat assets/secret.yaml  

# Deployment with proper configuration injection
cat assets/deployment.yaml
```

**Key Points to Highlight:**
- Environment variable injection
- Separation of config and secrets
- Kubernetes-native service discovery
- Proper labeling and namespace organization

## Quick Commands for Smooth Demo

### Fast Environment Teardown/Setup

```bash
# If something goes wrong, quick reset:
make teardown
make setup

# Usually takes 3-5 minutes
```

### Skip Analysis (If Time Pressed)

```bash
# Show pre-analyzed results by importing JSON
# This bypasses the analysis wait time
```

### Show Analysis Progress

```bash
# Multiple terminals for better experience
# Terminal 1: Main demo
# Terminal 2: Live logs
kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f

# Terminal 3: Resource monitoring
watch kubectl get pods -n my-konveyor-operator
```

## Timing Guide

**Total Demo Time: 15-20 minutes**

- Environment setup: 4-5 minutes
- UI access & overview: 2 minutes  
- Application import: 2-3 minutes
- Analysis execution: 5-7 minutes
- Results review: 3-4 minutes
- Asset demonstration: 2-3 minutes

## Pro Tips for Smooth Demo

### Before Starting
1. **Increase terminal font size** (16pt minimum)
2. **Hide desktop clutter** 
3. **Disable notifications**
4. **Have water nearby** (talking while typing)
5. **Practice the exact commands** 

### During Demo
1. **Speak while typing** - narrate what you're doing
2. **Use clear, deliberate movements** 
3. **Pause for audience questions**
4. **Don't panic on minor issues** - explain and continue
5. **Have backup screenshots ready**

### Terminal Best Practices
```bash
# Use clear, readable commands
echo "=== Clear section headers ==="

# Add pauses for audience
sleep 2

# Use time command to show performance  
time make setup

# Highlight important output
kubectl get pods -n my-konveyor-operator | grep -E "NAME|Running"
```

### Browser Tips
- **Bookmark key URLs**
- **Zoom to 125-150%** for better visibility
- **Use full-screen mode**
- **Have tabs ready** for different views
- **Clear browser history/suggestions**

## Backup Demo Options

### If Live Demo Fails

**Option 1: Screenshot Walkthrough**
- Prepared slides with UI screenshots
- Narrate the process step-by-step
- Focus on outcomes and insights

**Option 2: Pre-recorded Video**
- 10-minute recording of successful analysis
- Use as backup or supplementary material
- Can pause for discussion

**Option 3: Static Code Review**
- Show analysis results in documentation
- Walk through code examples manually
- Demonstrate remediation approaches

### Recovery Commands

```bash
# If analysis hangs
kubectl delete job -l app=tackle-analyzer -n my-konveyor-operator

# If UI is unresponsive  
kubectl delete pod -l app=tackle-ui -n my-konveyor-operator

# If complete restart needed
make teardown && make setup
```

## Success Metrics

### What Success Looks Like
- ✅ Environment setup completes without errors
- ✅ UI loads and is responsive
- ✅ Application import succeeds
- ✅ Analysis completes and shows issues
- ✅ Audience engagement and questions
- ✅ Clear demonstration of value proposition

### Fallback Success Criteria
- ✅ Concepts clearly explained even without live demo
- ✅ Audience understands the problem and solution
- ✅ Follow-up conversations initiated
- ✅ Repository shared for self-exploration

---

*Remember: The demo supports your message, but the message doesn't depend on a perfect demo. Focus on value delivery!*