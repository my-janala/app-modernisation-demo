# Presentation Troubleshooting Guide

## Common Issues & Quick Fixes

### Environment Setup Problems

#### Issue: Minikube fails to start
**Symptoms:**
```bash
make setup
# Error: Failed to start minikube cluster
```

**Quick Fixes:**
```bash
# Fix 1: Delete existing profile and retry
minikube delete -p konveyor-demo
minikube start --cpus=4 --memory=8192 --disk-size=40g -p konveyor-demo

# Fix 2: Reduce resource requirements
make CPUS=2 MEMORY=6144 setup

# Fix 3: Check Docker Desktop is running
docker ps
```

**Prevention:** Test full setup 30 minutes before presentation

#### Issue: Insufficient system resources
**Symptoms:** Pods stuck in "Pending" state, OutOfMemory errors

**Quick Fixes:**
```bash
# Check resource usage
kubectl top nodes
kubectl describe nodes

# Reduce demo complexity
kubectl delete namespace my-konveyor-operator
make CPUS=2 MEMORY=4096 setup
```

**Backup Plan:** Use screenshots and walk through conceptually

### Konveyor Deployment Issues

#### Issue: Konveyor pods not starting
**Symptoms:**
```bash
kubectl get pods -n my-konveyor-operator
# Shows pods in CrashLoopBackOff or ImagePullBackOff
```

**Diagnosis:**
```bash
kubectl describe pod <pod-name> -n my-konveyor-operator
kubectl logs <pod-name> -n my-konveyor-operator
```

**Quick Fixes:**
```bash
# Fix 1: Wait longer (can take 5-10 minutes)
kubectl wait --for=condition=Available deployment/tackle-ui -n my-konveyor-operator --timeout=600s

# Fix 2: Delete and recreate problematic pods
kubectl delete pod <pod-name> -n my-konveyor-operator

# Fix 3: Complete restart
make teardown
make setup
```

#### Issue: OLM installation fails
**Symptoms:** Operator Lifecycle Manager components not installing

**Quick Fixes:**
```bash
# Manual OLM installation
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/crds.yaml
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/olm.yaml

# Verify OLM is running
kubectl get pods -n olm
```

### UI Access Problems

#### Issue: Port forwarding fails
**Symptoms:**
```bash
make port-forward
# Error: Unable to forward port
```

**Quick Fixes:**
```bash
# Fix 1: Manual port forward with different port
kubectl port-forward svc/tackle-ui 8081:8080 -n my-konveyor-operator

# Fix 2: Check service exists
kubectl get svc -n my-konveyor-operator

# Fix 3: Use NodePort instead
kubectl patch svc tackle-ui -n my-konveyor-operator -p '{"spec":{"type":"NodePort"}}'
minikube service tackle-ui -n my-konveyor-operator -p konveyor-demo
```

#### Issue: UI loads but shows errors
**Symptoms:** Blank page, 500 errors, API connection issues

**Quick Fixes:**
```bash
# Check all pods are running
kubectl get pods -n my-konveyor-operator

# Restart UI components
kubectl delete pod -l app=tackle-ui -n my-konveyor-operator

# Check logs for specific errors
kubectl logs -l app=tackle-ui -n my-konveyor-operator
```

### Analysis Problems

#### Issue: Analysis gets stuck or fails
**Symptoms:** Analysis runs indefinitely, no progress updates

**Quick Fixes:**
```bash
# Check analyser jobs
kubectl get jobs -n my-konveyor-operator

# View analyser logs
kubectl logs -l app=tackle-analyser -n my-konveyor-operator

# Restart stuck analysis
kubectl delete job -l app=tackle-analyser -n my-konveyor-operator
# Then restart analysis in UI
```

#### Issue: Cannot upload application export
**Symptoms:** Import button doesn't work, file upload fails

**Quick Fixes:**
```bash
# Verify file exists and is valid JSON
cat assets/application-export.json | jq .

# Try manual application creation instead
# Use the UI to create application with these details:
# Name: customer-tomcat
# Repo: https://github.com/konveyor/example-applications  
# Branch: main
# Path: example-1/
```

### Network and Connectivity Issues

#### Issue: GitHub repository not accessible
**Symptoms:** Analysis fails to clone repository

**Quick Fixes:**
```bash
# Test connectivity from cluster
kubectl run test-pod --image=alpine --rm -it -- wget -qO- https://github.com/konveyor/example-applications/archive/main.zip

# Use alternative repository or local upload
# Show pre-downloaded analysis results instead
```

#### Issue: Internet connectivity problems
**Symptoms:** Container image pulls failing, timeouts

**Backup Plan:**
- Switch to offline slide presentation
- Use pre-recorded demo video
- Show static analysis results from documentation

## Audience Management

### Technical Difficulties During Presentation

#### If demo completely fails:
1. **Stay calm and acknowledge the issue**
   - "Technology demos - they keep us humble!"
   - "This is why we always have backup plans"

2. **Switch to backup content immediately**
   - Pre-prepared screenshots
   - Walk through the analysis-workflow.md
   - Show code examples from assets/

3. **Keep the audience engaged**
   - "While this would normally take 5 minutes to set up..."
   - "The key insight here is..."
   - Ask questions about their current modernisation challenges

#### If partial functionality works:
1. **Acknowledge what's working**
   - "Great, we can see the UI is accessible"
   - "The analysis results show exactly what we'd expect"

2. **Narrate missing pieces**
   - "If the analysis were running, we'd see..."
   - "The logs would show the analyser processing files"

3. **Focus on outcomes**
   - Show the issues that would be found
   - Explain the modernisation recommendations

### Handling Skeptical Questions

#### "This looks too simple for real applications"
**Response:**
- "You're absolutely right - this is a simplified demo"
- "In practice, enterprise applications have thousands of files"
- "Konveyor scales to analyse applications with millions of lines of code"
- "The same patterns apply, but the volume of findings is much larger"

#### "What about custom frameworks and libraries?"
**Response:**
- "Konveyor has extensible rulesets"
- "You can add custom rules for proprietary frameworks"
- "The AI component learns from your specific patterns"
- "Red Hat MTA includes additional enterprise rulesets"

#### "How accurate are these recommendations?"
**Response:**
- "95%+ accuracy for common modernisation patterns"
- "False positives are rare but can be filtered"
- "Human review is still essential for business logic decisions"
- "Think of it as an expert assistant, not a replacement"

### Time Management

#### If running behind schedule:
```bash
# Skip environment setup, show pre-built environment
kubectl get pods -n my-konveyor-operator
# "I've already prepared an environment for us..."

# Skip analysis waiting, show completed results
# "Rather than wait for analysis, let me show you typical findings..."

# Focus on high-impact issues only
# File system dependencies and hardcoded configurations
```

#### If running ahead of schedule:
- Deep dive into specific issues
- Show additional Kubernetes assets
- Demonstrate CLI tools
- Take more audience questions
- Show the modernisation-playbook.md content

## Backup Resources

### Pre-prepared Screenshots
Create screenshots of:
1. Clean Konveyor UI dashboard
2. Application import screen  
3. Analysis configuration page
4. Running analysis with progress
5. Completed analysis with issues list
6. Specific code issues with recommendations

### Alternative Demo Assets
```bash
# If main repository fails, use alternative
# Repository: https://github.com/spring-projects/spring-petclinic
# Branch: main
# This is a well-known application with similar issues
```

### Offline Content
- Analysis workflow documentation (docs/analysis-workflow.md)
- Code examples from assets/ directory
- Modernization playbook content
- Konveyor architecture diagrams

## Emergency Commands

### Complete Environment Reset
```bash
# Nuclear option - complete teardown and rebuild
make teardown
docker system prune -f
minikube delete -p konveyor-demo
make setup
# Takes 10-15 minutes
```

### Quick Health Checks
```bash
# Verify everything is working
kubectl get nodes
kubectl get pods -n my-konveyor-operator
curl -s http://localhost:8080 | grep -i konveyor
```

### Resource Monitoring
```bash
# Keep these running in separate terminal
watch kubectl get pods -n my-konveyor-operator
watch kubectl top pods -n my-konveyor-operator
```

## Pro Tips for Recovery

### Stay Professional
- Never blame the technology
- Keep energy positive
- Use humor appropriately
- Focus on learning opportunities

### Pivot Strategies
1. **Technical deep-dive**: If UI fails, show code analysis manually
2. **Strategic discussion**: Focus on business value and ROI
3. **Interactive session**: Turn into Q&A about modernisation challenges
4. **Case study approach**: Discuss real-world modernisation examples

### Communication Phrases
- "This gives us a perfect opportunity to discuss..."
- "In a real environment, you'd typically see..."
- "The key principle here is..."
- "Let me show you what this would look like..."

---

*Remember: Your expertise and knowledge are more valuable than a perfect demo. The technology supports your message, but your insights are what create real value for the audience.*