# Application Modernization Demo

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Konveyor](https://img.shields.io/badge/Powered%20by-Konveyor-orange.svg)](https://konveyor.io/)
[![CNCF Sandbox](https://img.shields.io/badge/CNCF-Sandbox-purple.svg)](https://www.cncf.io/projects/)

A comprehensive demonstration repository showcasing enterprise application modernization from legacy monoliths to cloud-native microservices. This project demonstrates the complete modernization journey using **Konveyor** (Migration Toolkit for Applications) with ready-to-use presentation materials, technical guides, and automated infrastructure setup.

## Overview

Transform your understanding of application modernization through a complete business transformation story. This repository provides everything needed to demonstrate how AI-powered assessment tools accelerate the journey from legacy systems to modern, scalable, cloud-native architectures.

**Key Benefits:**

- **Business-focused narrative** emphasizing ROI and transformation outcomes
- **Complete presentation package** for technical and executive audiences  
- **Hands-on demonstration** with real Konveyor assessment workflow
- **Automated environment setup** for consistent demos

## Presentation Materials

Ready-to-use presentation assets for technical meetups, executive briefings, and customer demonstrations.

| File | Description | Format |
|------|-------------|---------|
| **[SLIDES_MODERNIZATION.md](SLIDES_MODERNIZATION.md)** | Business-focused modernization journey presentation (27 slides) | Markdown |
| **[App_Modernization_Business_Slides.pptx](App_Modernization_Business_Slides.pptx)** | Professional PowerPoint presentation | PPTX (396KB) |
| **[PRESENTATION_GUIDE.md](PRESENTATION_GUIDE.md)** | Complete presentation guide with timing and setup | Markdown |
| **[DEMO_SCRIPT.md](DEMO_SCRIPT.md)** | Step-by-step Konveyor demonstration script | Markdown |
| **[SPEAKER_NOTES.md](SPEAKER_NOTES.md)** | Detailed speaker notes and Q&A preparation | Markdown |

### Presentation Themes

- **Business Transformation:** ROI-focused modernization narrative  
- **Technical Assessment:** AI-powered application analysis
- **Live Demonstration:** Real-time Konveyor workflow
- **Best Practices:** Success patterns and common pitfalls

## Technical Implementation

Comprehensive technical documentation for setting up and running the modernization assessment demonstration.

### Core Guides

| Guide | Purpose | Time Required |
|-------|---------|---------------|
| **[Setup Guide](docs/setup.md)** | Install Minikube, Konveyor, and troubleshoot issues | 15-20 minutes |
| **[Analysis Workflow](docs/analysis-workflow.md)** | Run application analysis and interpret findings | 10-15 minutes |
| **[Modernisation Playbook](docs/modernisation-playbook.md)** | Strategy context and next-step planning | Reference |
| **[Sample Assets](docs/setup.md#sample-assets)** | Pre-configured templates and exports | As needed |

### Additional Resources

- **[TROUBLESHOOTING_GUIDE.md](TROUBLESHOOTING_GUIDE.md)** – Common issues and solutions
- **[LOGO_USAGE_GUIDE.md](LOGO_USAGE_GUIDE.md)** – Konveyor branding guidelines
- **[convert_to_powerpoint.sh](convert_to_powerpoint.sh)** – Automated presentation generation

## Quick Start

Get up and running with the complete modernization demonstration in under 10 minutes.

### Prerequisites

- **Docker Desktop** (4GB+ RAM recommended)
- **Minikube** or local Kubernetes cluster  
- **kubectl** configured and accessible
- **Make** utility (standard on macOS/Linux)
- **Pandoc** (optional, for presentation generation)

### Installation

```bash
# Clone the repository
git clone https://github.com/my-janala/app-modernisation-demo.git
cd app-modernisation-demo

# Provision Minikube + Konveyor (15-20 minutes first time)
make setup

# Forward Konveyor UI to http://localhost:8080
make port-forward
```

### Demo Execution

1. **Open Konveyor UI:** Navigate to <http://localhost:8080>
2. **Import Application:** Upload `assets/application-export.json` or create manually
3. **Run Analysis:** Follow the [Analysis Workflow](docs/analysis-workflow.md)  
4. **Review Results:** Examine the Issues tab and modernization recommendations

### Cleanup

```bash
# Tear everything down when finished
make teardown
```

## Repository Structure

```txt
├── Presentation Materials/
│   ├── SLIDES_MODERNIZATION.md              # Authoritative presentation source  
│   ├── App_Modernization_Business_Slides.pptx  # Final PowerPoint (396KB)
│   ├── PRESENTATION_GUIDE.md                # Complete presentation guide
│   ├── DEMO_SCRIPT.md                       # Step-by-step demo script
│   ├── SPEAKER_NOTES.md                     # Speaker prep & Q&A
│   ├── TROUBLESHOOTING_GUIDE.md            # Technical troubleshooting
│   ├── LOGO_USAGE_GUIDE.md                 # Konveyor branding guidelines
│   └── convert_to_powerpoint.sh            # Automated presentation generation
│
├── Technical Implementation/
│   ├── docs/                               # Setup and analysis guides
│   │   ├── setup.md                       # Environment provisioning
│   │   ├── analysis-workflow.md           # Assessment workflow
│   │   └── modernisation-playbook.md      # Strategy and planning
│   ├── assets/                            # Demo assets and templates
│   │   ├── application-export.json        # Sample application data
│   │   ├── logos/                         # Official Konveyor branding
│   │   ├── configmap.yaml                 # Kubernetes configuration
│   │   ├── deployment.yaml                # Deployment templates
│   │   └── secret.yaml                    # Secret templates
│   ├── images/                            # Supporting diagrams
│   └── Makefile                           # Automated environment setup
│
└── Community/
    ├── CONTRIBUTING.md                     # Contribution guidelines
    ├── CODE_OF_CONDUCT.md                 # Community standards
    ├── SECURITY.md                        # Security policies
    ├── LICENSE                            # Apache 2.0 license
    └── .github/                           # Issue and PR templates
```

## Use Cases

This demonstration repository is designed for multiple audiences and scenarios:

### For Presenters

- **Technical Meetups:** Cloud-native and Kubernetes community presentations
- **Executive Briefings:** Business-focused modernization discussions
- **Customer Demonstrations:** Sales and consulting engagements
- **Training Sessions:** Internal team education and workshops

### For Organizations

- **Assessment Strategy:** Understanding modernization readiness evaluation
- **Tool Evaluation:** Exploring Konveyor capabilities and benefits
- **Business Case Development:** Building ROI arguments for modernization initiatives
- **Best Practices Learning:** Understanding successful modernization patterns

## Key Features

### Business Value Demonstration
- **ROI-focused presentation** with real metrics (70% cost reduction, 99.8% faster deployment)
- **Complete transformation story** from legacy monolith to cloud-native microservices
- **Executive-friendly narrative** emphasizing business outcomes over technical details
- **Success patterns and pitfalls** from real-world modernization projects

### Technical Capabilities
- **AI-powered assessment** demonstrating automated application analysis
- **Real-time demonstration** with actual Konveyor workflow execution
- **Comprehensive setup automation** for consistent demo environments
- **Professional presentation assets** ready for corporate use

### Educational Content
- **Step-by-step guides** for complete learning experience
- **Troubleshooting documentation** for common issues and solutions
- **Best practices documentation** for successful modernization projects
- **Community resources** and contribution guidelines

## Contributing

We welcome contributions to improve this demonstration repository. Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:

- Submitting presentation improvements
- Adding technical documentation  
- Reporting issues and bugs
- Proposing new features

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Support and Community

- **Issues:** Report bugs and request features via [GitHub Issues](https://github.com/my-janala/app-modernisation-demo/issues)
- **Discussions:** Join community discussions about application modernization
- **Konveyor Community:** Connect with the broader [Konveyor community](https://konveyor.io/community/)

## References and Resources

### Konveyor Project
- **[Konveyor Official Website](https://konveyor.io/)** - Main project portal and documentation
- **[Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)** - Technical product overview
- **[Konveyor GitHub Organization](https://github.com/konveyor)** - Source code and community projects

### Documentation and Guides  
- **[Konveyor Modernization Report](https://konveyor.io/modernization-report/)** - Industry insights and trends
- **[Konveyor Methodology](https://github.com/konveyor/methodology)** - Modernization best practices
- **[Kube by Example Tutorial](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)** - Hands-on learning path

### Cloud Native Ecosystem
- **[CNCF Landscape](https://landscape.cncf.io/)** - Cloud-native project ecosystem
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Container orchestration platform
- **[Cloud Native Computing Foundation](https://www.cncf.io/)** - Open source cloud-native ecosystem
