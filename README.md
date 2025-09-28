# app-modernisation-demo

Modernisation demo for a legacy Tomcat application using Konveyor / Migration Toolkit for Applications (MTA). The repository bundles guides, runnable assets, and automation to provision Konveyor locally, analyse the sample application, and plan remediation.

## Quick Links

- [Setup Guide](docs/setup.md) – provision Minikube, install Konveyor, and troubleshoot common issues.
- [Analysis Workflow](docs/analysis-workflow.md) – import/run the sample application analysis and interpret findings.
- [Modernisation Playbook](docs/modernisation-playbook.md) – explore strategy context, Konveyor components, and next-step planning.
- [Sample Assets](docs/setup.md#sample-assets) – ConfigMap/Secret/Deployment templates and application export for quick demos.

## Fast Start

```bash
# Provision Minikube + Konveyor
make setup

# Forward Konveyor UI to http://localhost:8080
make port-forward

# Tear everything down when finished
make teardown
```

After setup, open the Analysis Workflow to upload `assets/application-export.json` or create the application manually, then run an analysis and review the Issues tab.

## Repository Layout

- `docs/` – detailed setup, analysis, and modernisation guides.
- `assets/` – sample Konveyor export plus Kubernetes templates for the customer application.
- `images/` – supporting diagrams referenced from the documentation.
- `Makefile` – automation to create/destroy the local Konveyor environment.
- Community files: see [CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), and the issue/PR templates under `.github/`.

## References

- [Konveyor](https://konveyor.io/)
- [Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)
- [Konveyor Modernization Report](https://konveyor.io/modernization-report/)
- [Konveyor Methodology](https://github.com/konveyor/methodology)
- [Kube by Example: Install Konveyor and Analyse Legacy Java Application](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)
