# Modernisation Playbook

Use this playbook to understand the motivation for modernising the legacy Tomcat application, explore Konveyor capabilities, and plan the journey beyond analysis.

## Context: Application Modernisation and Konveyor

Application modernisation transforms legacy systems so they can leverage modern architectures and cloud-native platforms. Benefits include better scalability, reliability, security, and reduced technical debt.

Modernisation is rarely one-size-fits-all. Konveyor helps teams evaluate the classic “Rs” strategies and decide which path fits each workload:

- **Retain:** Leave the application as-is when it continues to meet requirements.
- **Retire:** Decommission applications that no longer deliver value.
- **Rehost ("Lift and Shift"):** Move the application to new infrastructure with minimal changes.
- **Replatform ("Lift, Tinker, Shift"):** Adopt a new platform while making incremental improvements (e.g., containerisation, managed databases).
- **Refactor ("Re-architect"):** Restructure the application for maintainability, scalability, or cloud-native patterns.
- **Repurchase ("Drop and Shop"):** Replace the legacy application with a modern SaaS solution.

Konveyor delivers automated analysis and actionable recommendations so teams can modernise at their own pace.

## Why Modernise a Legacy Tomcat Application?

The `example-1` Tomcat application represents workloads still running on traditional infrastructure. Common pain points include:

- Operational complexity from manual server/VM management.
- Limited scalability and elasticity.
- Security gaps due to slow patch cadences.
- High maintenance costs and specialised skills requirements.
- Limited agility when integrating with modern services or CI/CD pipelines.
- Accumulating technical debt.

Modernising with Konveyor enables migrations to Kubernetes, improved reliability, lower operational cost, and faster iteration cycles.

## About Konveyor and KAI

Konveyor is an open-source toolkit that accelerates application modernisation through automated analysis, planning, and transformation. Key components include **Tackle**, **Konveyor Hub**, **Konveyor CLI**, and **Konveyor AI (KAI)**. Red Hat’s Migration Toolkit for Applications (MTA) builds on Konveyor and adds enterprise support.

### Dedicated KAI Section

KAI augments the stack with AI-assisted insights:

- Deep code and configuration analysis using LLMs.
- Actionable recommendations for refactoring, replatforming, and containerisation.
- Guidance on LLM selection and prompt tuning; see the [LLM selection guidelines](https://github.com/konveyor/kai/blob/main/docs/llm_selection.md).
- Continuous improvement as feedback is incorporated.

## More About Konveyor

Konveyor’s methodology encourages portfolio assessment, iterative modernisation, and collaboration. Major toolkit elements include:

- **Tackle:** Assessment and migration planning.
- **KAI:** AI-powered analysis and recommendations.
- **Move2Kube:** Automated containerisation/Kubernetes asset generation.
- **Forklift:** VM and infrastructure migration.
- **Konveyor Hub:** Centralised planning and execution hub.
- **Konveyor CLI:** Automation and integration entry point.

Reasons to adopt Konveyor:

- Accelerated modernisation with proven rulesets.
- Cloud-native readiness.
- Open-source, community-driven roadmap.
- End-to-end guidance from assessment to execution.

## Next Steps After Analysis

Once the analyzer highlights issues, prioritise remediation and planning:

1. Review findings and categorise blockers vs. quick wins.
2. Update application assessments within Konveyor Hub.
3. Produce remediation tasks (configuration updates, refactors, dependency upgrades).
4. Containerise and automate deployments with CI/CD.
5. Iterate towards cloud-native architecture.

![What to do after an application is reviewed and analysed by Konveyor](../images/modernisation-overview.png)
*Figure: Workflow after a Konveyor analysis*

## Diagram Overview

The diagram summarises the journey:

1. **Migration Toolkit for Applications (MTA):** Analyses code, surfaces dependencies, and generates transformation guidance.
   - Highlight supported runtimes such as [Java EE](https://www.oracle.com/java/technologies/java-ee-glance.html) and [.NET](https://dotnet.microsoft.com/en-us/learn/dotnet/what-is-dotnet).
2. **Konveyor Hub:** Central hub with spokes for Assessment, Planning, Analysis & Transformation, Reports, Integration & Automation, and Execution.
   - Note integrations with tooling ecosystems (IDEs, CI/CD).
3. **Typical Workflow:** Run MTA → Review reports → Apply changes → Refactor → Containerise.
   - Distinguish manual vs. automated activities.
4. **Containerisation & CI/CD:** Tooling such as Tekton, Argo CD, automation frameworks, and artifact stores.
   - Consider inserting security/testing stages (Trivy, SonarQube) in pipelines.
5. **Namespaces:** Sample `retail` namespace houses microservices, databases, and APIs; `argocd` namespace orchestrates deployment.
   - Document traffic patterns (REST, gRPC) between services when tailoring the model.

## References

- [Konveyor](https://konveyor.io/)
- [Konveyor Methodology](https://github.com/konveyor/methodology)
- [Konveyor Modernization Report](https://konveyor.io/modernization-report/)
- [Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)
- [Kube by Example: Install Konveyor and Analyse Legacy Java Application](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)

