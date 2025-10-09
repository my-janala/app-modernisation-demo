

# Application Modernisation Demo

---

## Introduction & Overview

This repository demonstrates enterprise application modernisation using Konveyor. It provides a hands-on journey from legacy monoliths to cloud-native microservices, with guides, assets, and automation for technical and business audiences. The project showcases how AI-powered assessment tools accelerate the journey from legacy systems to modern, scalable, cloud-native architectures.

> **Note:** The Quick Start installation process currently has an issue—Konveyor must be deployed manually for now. A fix is in progress.

**Key Benefits:**

- Business-focused narrative emphasizing ROI and transformation outcomes
- Complete presentation package for technical and executive audiences
- Hands-on demonstration with real Konveyor assessment workflow
- Automated environment setup for consistent demos

---

## Quick Start

Get started with the modernisation demo in minutes:

> ⚠️ **Known Issue:** The automated Quick Start (`make setup`) may fail due to an OLM/Konveyor deployment bug. Please follow the manual setup steps in the [Setup Guide](docs/setup.md) until this is resolved. Konveyor has been deployed manually for this demo.

**Summary:**

1. Prepare your environment (Docker Desktop, Minikube, kubectl, Make)
2. Clone the repository
3. Follow the [Setup Guide](docs/setup.md) for installation and configuration
4. See [Demo Execution](#demo-execution) for the workflow overview

For all commands and troubleshooting, refer to the [Setup Guide](docs/setup.md).

---

### Demo Execution

The demo workflow consists of:

1. Verifying Konveyor components are running
2. Opening the Konveyor UI
3. Importing your application for analysis
4. Running the analysis and reviewing results

For detailed setup steps and commands, please refer to the [Setup Guide](docs/setup.md).


---

## Troubleshooting

See [TROUBLESHOOTING_GUIDE.md](TROUBLESHOOTING_GUIDE.md) for common issues and solutions (Minikube, Docker, Konveyor, etc.)

---



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

A: See the [CONTRIBUTING.md](CONTRIBUTING.md) and use the GitHub issue templates.

**Q: Where is the code of conduct?**

A: See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).


---

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

---


## Contributing

We welcome contributions to improve this demonstration repository. Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:
---

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


## Further Reading and Resources



### Konveyor Project Links

- **[Konveyor Official Website](https://konveyor.io/)** - Main project portal and documentation
- **[Migration Toolkit for Applications](https://developers.redhat.com/products/mta/overview)** - Technical product overview
- **[Konveyor GitHub Organization](https://github.com/konveyor)** - Source code and community projects

### Modernisation Documentation

- **[Konveyor Modernisation Report](https://konveyor.io/modernisation-report/)** - Industry insights and trends
- **[Konveyor Methodology](https://github.com/konveyor/methodology)** - Modernisation best practices
- **[Kube by Example Tutorial](https://kubebyexample.com/learning-paths/migrating-kubernetes/install-konveyor-and-analyse-legacy-java-application)** - Hands-on learning path

### Cloud Native Resources

- **[CNCF Landscape](https://landscape.cncf.io/)** - Cloud-native project ecosystem
- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Container orchestration platform
- **[Cloud Native Computing Foundation](https://www.cncf.io/)** - Open source cloud-native ecosystem


## About the Author




Mezbaur Rahman — Platform Engineer at CIS Capgemini, specialising in cloud-native technologies and application modernisation.

- [LinkedIn](https://www.linkedin.com/in/mezba/)
- [Technical Blog](https://medium.com/@mezba)

---