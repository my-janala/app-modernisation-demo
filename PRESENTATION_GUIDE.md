# App Modernization Demo - Presentation Guide

## Presentation Overview

**Duration:** 45-60 minutes (30 min presentation + 15-30 min demo)  
**Audience:** Technical teams, architects, platform engineers, management  
**Objective:** Demonstrate practical application modernization using Konveyor/MTA

---

## Pre-Presentation Checklist

### Technical Prerequisites
- [ ] Docker Desktop running
- [ ] Minikube installed and tested
- [ ] kubectl configured
- [ ] Java 17+ available
- [ ] 8GB+ RAM available for demo
- [ ] Stable internet connection
- [ ] Backup slides/screenshots ready

### Environment Validation
```bash
# Run these commands 30 minutes before presentation
docker --version
minikube version
kubectl version --client
java -version

# Test the full setup (takes 5-10 minutes)
make setup
make port-forward
# Verify http://localhost:8080 loads
make teardown
```

---

## Presentation Structure

### 1. Opening Hook (5 minutes)
**Key Message:** "Legacy applications are business assets, not liabilities"

**Talking Points:**
- 70% of enterprise workloads still run on traditional infrastructure
- Modernization isn't about replacement - it's about evolution
- Show the modernization overview diagram (`images/modernisation-overview.png`)

**Audience Engagement:**
- "How many of you are managing applications older than 5 years?"
- "What's your biggest pain point with legacy systems?"

### 2. The Modernization Challenge (8 minutes)
**Key Message:** "Modernization requires assessment before action"

**Content:**
- The 6 R's of modernization (Retain, Retire, Rehost, Replatform, Refactor, Repurchase)
- Why automated analysis matters
- Common legacy application issues:
  - Hardcoded configurations
  - File system dependencies
  - Tight coupling
  - Security vulnerabilities

**Visual Aid:** Show examples from the analysis-workflow.md

### 3. Konveyor Solution Overview (7 minutes)
**Key Message:** "Konveyor provides AI-powered automation for modernization"

**Components to Highlight:**
- **Tackle:** Assessment and planning
- **Konveyor AI (KAI):** LLM-powered recommendations
- **Hub:** Centralized management
- **Move2Kube:** Containerization automation

**Why Konveyor:**
- Open-source, community-driven
- Proven rulesets from real migrations
- End-to-end workflow support
- Enterprise backing (Red Hat MTA)

### 4. Live Demo Introduction (5 minutes)
**Key Message:** "From legacy Tomcat to Kubernetes in minutes"

**Demo Setup:**
- Explain the sample application (Tomcat-based)
- Show repository structure
- Highlight automation approach
- Set expectations for what we'll see

---

## Live Demo Script

### Phase 1: Environment Setup (3-4 minutes)

```bash
# Show the simplicity
echo "Starting from zero - no Kubernetes cluster"
minikube status konveyor-demo || echo "Clean environment confirmed"

# One command setup
echo "Setting up complete modernization environment..."
make setup
```

**While it runs, explain:**
- Minikube cluster creation
- OLM (Operator Lifecycle Manager) installation
- Konveyor operator deployment
- Resource allocation and scaling

**Validation commands:**
```bash
# Show what was created
kubectl get nodes
kubectl get namespaces
kubectl get pods -n my-konveyor-operator
```

### Phase 2: Access Konveyor UI (2 minutes)

```bash
# Port forward in background
make port-forward &
echo "Konveyor UI available at http://localhost:8080"
```

**Browser Demo:**
1. Open http://localhost:8080
2. Navigate to Applications tab
3. Show empty state
4. Explain the UI components

### Phase 3: Import Sample Application (3 minutes)

**Option A - JSON Import (Recommended for demos):**
1. Click "Import" in Applications
2. Upload `assets/application-export.json`
3. Show imported application details
4. Explain metadata and tags

**Option B - Manual Creation (For detailed explanation):**
1. Create new application
2. Name: "customer-tomcat"
3. Repository: `https://github.com/konveyor/example-applications`
4. Branch: "main"
5. Root path: "example-1/"

### Phase 4: Run Analysis (5-7 minutes)

```bash
# Show analysis progress in terminal
kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f
```

**In UI:**
1. Select application
2. Click "Analyze"
3. Choose targets: "Containerization" and "Kubernetes"
4. Start analysis
5. Monitor progress

**While waiting, explain:**
- Static code analysis process
- Rule-based detection
- AI-enhanced recommendations
- Analysis targets and their significance

### Phase 5: Review Findings (8-10 minutes)

**Key Issues to Highlight:**

1. **File System Dependencies**
   ```java
   // Show in UI Issues tab
   InputStream inputStream = new FileInputStream("/opt/config/persistence.properties");
   ```
   - **Problem:** Hardcoded paths, ephemeral storage
   - **Solution:** ConfigMaps and environment variables

2. **Hardcoded IP Addresses**
   ```properties
   jdbc.url=jdbc:oracle:thin:@169.60.225.216:1521/XEPDB1
   ```
   - **Problem:** No portability, manual updates
   - **Solution:** Service discovery and DNS

3. **Configuration Management**
   - Show how legacy apps manage config
   - Demonstrate Kubernetes-native alternatives

**Show the Kubernetes assets:**
```bash
# Display the modernized approach
cat assets/configmap.yaml
cat assets/secret.yaml
cat assets/deployment.yaml
```

### Phase 6: Modernization Path (3 minutes)

**Explain the transformation:**

**Before (Legacy):**
- Manual server management
- Hardcoded configurations
- File-based storage
- Manual scaling

**After (Cloud-Native):**
- Kubernetes orchestration
- Environment-based configuration  
- Persistent volumes and services
- Auto-scaling capabilities

**Show practical examples from the assets folder**

---

## Key Messages & Talking Points

### For Technical Audience:
- "Konveyor reduces analysis time from weeks to hours"
- "AI-powered recommendations based on thousands of real migrations"
- "Open-source with enterprise support through Red Hat MTA"
- "Integrates with existing CI/CD pipelines"

### For Management:
- "Reduces modernization risk through automated assessment"
- "Accelerates time-to-cloud by 60-80%"
- "Provides clear ROI metrics and migration roadmaps"
- "Minimizes downtime during transitions"

### For Architects:
- "Supports incremental modernization strategies"
- "Maintains architectural consistency across portfolios"
- "Enables cloud-native patterns adoption"
- "Provides technical debt visibility"

---

## Backup Plans & Troubleshooting

### If Demo Environment Fails:
1. **Have screenshots ready** of each UI screen
2. **Pre-recorded video** of the analysis running
3. **Static analysis results** to show findings
4. **Code examples** from the documentation

### Common Issues & Quick Fixes:

**Minikube won't start:**
```bash
minikube delete -p konveyor-demo
minikube start --cpus=4 --memory=8192 --disk-size=40g -p konveyor-demo
```

**Konveyor pods not ready:**
```bash
kubectl get pods -n my-konveyor-operator
kubectl describe pod <pod-name> -n my-konveyor-operator
# Usually resource constraints - explain and continue with slides
```

**UI not accessible:**
```bash
kubectl get svc -n my-konveyor-operator
kubectl port-forward svc/tackle-ui 8080:8080 -n my-konveyor-operator
```

**Analysis stuck:**
```bash
kubectl get jobs -n my-konveyor-operator
kubectl logs job/<analyzer-job> -n my-konveyor-operator
# Show logs and explain the process
```

---

## Metrics to Highlight

- **Setup Time:** < 10 minutes for complete environment
- **Analysis Speed:** Hundreds of files analyzed in minutes
- **Issue Detection:** Automated identification of 50+ common patterns
- **Accuracy:** 95%+ precision in identifying modernization blockers
- **ROI:** 60-80% reduction in modernization planning time

---

## Audience Q&A Preparation

### Expected Questions:

**"How does this compare to manual code review?"**
- Manual review: Weeks/months, inconsistent, human error
- Konveyor: Hours/days, consistent rules, AI-enhanced

**"What about complex, custom applications?"**
- Konveyor provides extensible rulesets
- Custom rules can be added
- AI learns from feedback

**"Integration with existing tools?"**
- CLI for automation
- REST APIs for integration
- Supports major CI/CD platforms

**"Cost and licensing?"**
- Open-source Konveyor is free
- Red Hat MTA provides enterprise support
- ROI through faster modernization

**"What about security and compliance?"**
- Built-in security rule detection
- Compliance framework mapping
- CVE identification and remediation paths

---

## Closing & Next Steps

### Call to Action:
1. **Try the demo yourself** - Repository provides complete setup
2. **Join the community** - Konveyor Slack, GitHub discussions  
3. **Start small** - Pilot with non-critical applications
4. **Plan strategically** - Use findings to build modernization roadmap

### Resources to Share:
- GitHub Repository: `github.com/my-janala/app-modernisation-demo`
- Konveyor Website: `konveyor.io`
- Red Hat MTA: `developers.redhat.com/products/mta`
- Community Slack: `konveyor.slack.com`

---

## Speaker Notes

### Energy Management:
- Start with high energy and engagement
- Use the live demo to maintain interest
- Interact with audience during analysis wait times
- Have backup content ready for technical delays

### Technical Depth:
- Adjust complexity based on audience
- Focus on business value for mixed audiences  
- Dive into technical details for engineering teams
- Always connect features to real-world problems

### Demo Confidence:
- Practice the full demo 3+ times
- Know the fallback options
- Embrace minor issues as learning opportunities
- Keep the focus on outcomes, not perfection

---

*This guide ensures your presentation delivers maximum impact while demonstrating the real value of modern application modernization approaches.*