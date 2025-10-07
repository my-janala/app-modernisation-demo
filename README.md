# Application Modernization Demo

Complete application modernization demonstration showcasing business transformation from legacy systems to cloud-native architecture using Konveyor / Migration Toolkit for Applications (MTA). This repository includes presentation materials, technical guides, and automation for demonstrating AI-powered modernization assessment.

## 🚀 Presentation Materials

- **[SLIDES_MODERNIZATION.md](SLIDES_MODERNIZATION.md)** – Business-focused presentation on application modernization journey (27 slides)
- **[App_Modernization_Business_Slides.pptx](App_Modernization_Business_Slides.pptx)** – Ready-to-present PowerPoint version (396KB)
- **[PRESENTATION_GUIDE.md](PRESENTATION_GUIDE.md)** – Complete presentation guide with timing and technical setup
- **[DEMO_SCRIPT.md](DEMO_SCRIPT.md)** – Step-by-step demo script for Konveyor demonstration
- **[SPEAKER_NOTES.md](SPEAKER_NOTES.md)** – Detailed speaker notes and Q&A preparation

## 📚 Technical Guides

- [Setup Guide](docs/setup.md) – provision Minikube, install Konveyor, and troubleshoot common issues
- [Analysis Workflow](docs/analysis-workflow.md) – import/run the sample application analysis and interpret findings  
- [Modernisation Playbook](docs/modernisation-playbook.md) – explore strategy context, Konveyor components, and next-step planning
- [Sample Assets](docs/setup.md#sample-assets) – ConfigMap/Secret/Deployment templates and application export for quick demos

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

## 📁 Repository Structure

```txt
📁 Presentation Materials
├── SLIDES_MODERNIZATION.md              # Business-focused presentation source
├── App_Modernization_Business_Slides.pptx  # Final PowerPoint presentation  
├── PRESENTATION_GUIDE.md                # Complete presentation guide
├── DEMO_SCRIPT.md                       # Step-by-step Konveyor demo
├── SPEAKER_NOTES.md                     # Speaker notes & Q&A prep
├── TROUBLESHOOTING_GUIDE.md            # Technical troubleshooting
└── convert_to_powerpoint.sh             # Automated PowerPoint generation

📁 Technical Assets  
├── docs/                               # Setup, analysis, and modernization guides
├── assets/                            # Sample Konveyor exports & Kubernetes templates
├── assets/logos/                      # Official Konveyor branding assets
├── images/                           # Supporting diagrams and visuals
└── Makefile                          # Automated local Konveyor environment

📁 Community
├── CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md
└── .github/                          # Issue and PR templates
```

## References

- [Konveyor](https://konveyor.io/)
- [Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)
- [Konveyor Modernization Report](https://konveyor.io/modernization-report/)
- [Konveyor Methodology](https://github.com/konveyor/methodology)
- [Kube by Example: Install Konveyor and Analyse Legacy Java Application](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)
