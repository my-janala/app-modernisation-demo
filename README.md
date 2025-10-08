# Application Modernisation Demo
  
## Frequently Asked Questions (FAQ)

**Q: How do I set up the demo environment?**
A: See the [Quick Start](#quick-start) section above, or run `./setup_demo.sh` for automated setup.

**Q: Where can I find detailed setup instructions?**
A: Refer to the [Setup Guide](docs/setup.md).

**Q: How do I run the Konveyor analysis?**
A: Follow the [Analysis Workflow](docs/analysis-workflow.md) for step-by-step instructions.

**Q: What if I encounter issues with Minikube, Docker, or Konveyor?**
A: Check the [Troubleshooting Guide](TROUBLESHOOTING_GUIDE.md) for common problems and solutions.

**Q: How can I contribute or report bugs?**
A: See the [Community & Contribution](#community--contribution) section and use the GitHub issue templates.

**Q: Where is the code of conduct?**
A: See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
  
## Community & Contribution

We welcome contributions and feedback from the community!

### How to Contribute
- Fork the repository and create your branch from `develop`.
- Submit pull requests with clear descriptions and reference related issues.
- Review our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines and best practices.
- For bug reports or feature requests, use the GitHub issue templates provided.

### Code of Conduct
- Please read and follow our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) to ensure a welcoming and respectful environment for all contributors.

We value collaboration and strive to make this project useful for everyone interested in application modernisation.

## Quick Start

Get up and running with the modernisation demo in minutes.

### Prerequisites
- Docker Desktop (4GB+ RAM recommended)
- Minikube (local Kubernetes cluster)
- kubectl (Kubernetes CLI)
- Java 17 or later

### Install Essentials (macOS example)
```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
sudo install -o root -g wheel -m 0755 kubectl /usr/local/bin/kubectl
```

### Provision Everything (Makefile)
```bash
make setup
```
This will start Minikube, install required addons, and deploy Konveyor automatically.

### Run the Demo
Follow the [Analysis Workflow](docs/analysis-workflow.md) to assess a sample legacy application and view results in the Konveyor UI.

### More Details
- [Setup Guide](docs/setup.md): Full environment setup and configuration
- [Analysis Workflow](docs/analysis-workflow.md): Step-by-step demo instructions

### Troubleshooting
- See [TROUBLESHOOTING_GUIDE.md](TROUBLESHOOTING_GUIDE.md) for common issues and solutions (Minikube, Docker, Konveyor, etc.)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Konveyor](https://img.shields.io/badge/Powered%20by-Konveyor-orange.svg)](https://konveyor.io/)
[![CNCF Sandbox](https://img.shields.io/badge/CNCF-Sandbox-purple.svg)](https://www.cncf.io/projects/)

A comprehensive demonstration repository showcasing enterprise application modernisation from legacy monoliths to cloud-native microservices. This project demonstrates the complete modernisation journey using **Konveyor** (Migration Toolkit for Applications) with ready-to-use presentation materials, technical guides, and automated infrastructure setup.

## Overview

Transform your understanding of application modernisation through a complete business transformation story. This repository provides everything needed to demonstrate how AI-powered assessment tools accelerate the journey from legacy systems to modern, scalable, cloud-native architectures.

**Key Benefits:**

- **Business-focused narrative** emphasizing ROI and transformation outcomes
- **Complete presentation package** for technical and executive audiences  
- **Hands-on demonstration** with real Konveyor assessment workflow
- **Automated environment setup** for consistent demos

## About the Author

**Mezbaur Rahman** is a Platform Engineer at CIS Capgemini, specialising in cloud-native technologies, application modernisation, and enterprise transformation initiatives. With extensive experience in containerisation, Kubernetes, and modern DevOps practices, Mezba helps organisations navigate their journey from legacy systems to scalable, cloud-native architectures.

**Connect with Mezba:**
- 🔗 **LinkedIn:** [linkedin.com/in/mezba](https://www.linkedin.com/in/mezba/)
- 📝 **Technical Blog:** [medium.com/@mezba](https://medium.com/@mezba)
- 💼 **Professional Focus:** Platform Engineering, Application Modernisation, Cloud-Native Architecture

**Expertise Areas:**
- Enterprise application modernisation strategies
- Kubernetes and container orchestration
- Platform engineering and DevOps transformation  
- Cloud-native architecture design and implementation

## Presentation Materials

Ready-to-use presentation assets for technical meetups, executive briefings, and customer demonstrations.

| File | Description | Format |
|------|-------------|---------|
| **[SLIDES_MODERNISATION.md](SLIDES_MODERNISATION.md)** | Business-focused modernisation journey presentation (~15 slides) | Markdown |
| **[App_Modernisation_Business_Slides.pptx](App_Modernisation_Business_Slides.pptx)** | PowerPoint version of the modernisation journey (for executive/technical audiences) | PPTX |
| **[PRESENTATION_GUIDE.md](PRESENTATION_GUIDE.md)** | Complete presentation guide with timing and setup | Markdown |
| **[DEMO_SCRIPT.md](DEMO_SCRIPT.md)** | Step-by-step Konveyor demonstration script | Markdown |
| **[SPEAKER_NOTES.md](SPEAKER_NOTES.md)** | Detailed speaker notes and Q&A preparation | Markdown |

### Presentation Themes

- **Business Transformation:** ROI-focused modernisation narrative  
- **Technical Assessment:** AI-powered application analysis
- **Live Demonstration:** Real-time Konveyor workflow
- **Best Practices:** Success patterns and common pitfalls

## Technical Implementation

Comprehensive technical documentation for setting up and running the modernisation assessment demonstration.

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

Get up and running with the complete modernisation demonstration in under 10 minutes.

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

# Confirm the environment is healthy
make verify

# Forward Konveyor UI to http://localhost:8080 (backgrounds tunnel, logs to /tmp/konveyor-port-forward.log)
make port-forward
```

If the Minikube OLM addon is unhealthy on your workstation, rerun the setup with pinned manifests:

```bash
make INSTALL_OLM_MANUALLY=true setup
```

### Demo Execution

1. **Verify components (optional repeat):** `make verify` or `kubectl --context konveyor-demo get pods -n my-konveyor-operator`
2. **Open Konveyor UI:** After the background `make port-forward`, browse to <http://localhost:8080>. Check `/tmp/konveyor-port-forward.log` for tunnel logs; stop it later with `pkill -f 'port-forward svc/tackle-ui'` or `make teardown`.
3. **Import Application:** Upload `assets/application-export.json` or create manually
4. **Run Analysis:** Follow the [Analysis Workflow](docs/analysis-workflow.md) and optionally watch progress with `kubectl logs -l app=tackle-analyzer -n my-konveyor-operator -f`  
5. **Review Results:** Examine the Issues tab and modernisation recommendations

### Cleanup

```bash
# Tear everything down when finished
make teardown
```

## Repository Structure

```txt
├── Presentation Materials/
│   ├── SLIDES_MODERNISATION.md              # Authoritative presentation source  
│   ├── App_Modernisation_Business_Slides.pptx  # Final PowerPoint (396KB)
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
- **Executive Briefings:** Business-focused modernisation discussions
- **Customer Demonstrations:** Sales and consulting engagements
- **Training Sessions:** Internal team education and workshops

### For Organisations

- **Assessment Strategy:** Understanding modernisation readiness evaluation
- **Tool Evaluation:** Exploring Konveyor capabilities and benefits
- **Business Case Development:** Building ROI arguments for modernisation initiatives
- **Best Practices Learning:** Understanding successful modernisation patterns

## Key Features

### Business Value Demonstration
- **ROI-focused presentation** with real metrics (70% cost reduction, 99.8% faster deployment)
- **Complete transformation story** from legacy monolith to cloud-native microservices
- **Executive-friendly narrative** emphasizing business outcomes over technical details
- **Success patterns and pitfalls** from real-world modernisation projects

### Technical Capabilities
- **AI-powered assessment** demonstrating automated application analysis
- **Real-time demonstration** with actual Konveyor workflow execution
- **Comprehensive setup automation** for consistent demo environments
- **Professional presentation assets** ready for corporate use

### Educational Content
- **Step-by-step guides** for complete learning experience
- **Troubleshooting documentation** for common issues and solutions
- **Best practices documentation** for successful modernisation projects
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
- **Discussions:** Join community discussions about application modernisation
- **Konveyor Community:** Connect with the broader [Konveyor community](https://konveyor.io/community/)

## References and Resources

### Konveyor Project
- **[Konveyor Official Website](https://konveyor.io/)** - Main project portal and documentation
- **[Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)** - Technical product overview
- **[Konveyor GitHub Organization](https://github.com/konveyor)** - Source code and community projects

### Documentation and Guides  
- **[Konveyor Modernisation Report](https://konveyor.io/modernisation-report/)** - Industry insights and trends
- **[Konveyor Methodology](https://github.com/konveyor/methodology)** - Modernisation best practices
- **[Kube by Example Tutorial](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)** - Hands-on learning path

### Cloud Native Ecosystem
- **[CNCF Landscape](https://landscape.cncf.io/)** - Cloud-native project ecosystem
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Container orchestration platform
- **[Cloud Native Computing Foundation](https://www.cncf.io/)** - Open source cloud-native ecosystem
