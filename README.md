# Enterprise Hybrid-Cloud NetOps & Infrastructure Framework (`erk-netops-framework`)

![License](https://img.shields.io/github/license/abmdi/erk-netops-framework?color=blue)
![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple)
![Python](https://img.shields.io/badge/Python-3.10+-blue)
![Build](https://img.shields.io/badge/Build-Passing-brightgreen)

A production-ready reference architecture and automation framework for Enterprise Hybrid Cloud environments, Network Infrastructure as Code (NIaC), Zero Trust Security, and Automated Observability.

---

## Architecture & Modules Scope

* **Cloud Infrastructure (IaC):** Modular Terraform blueprints for AWS (Transit Gateway, Multi-VPC), Azure (ExpressRoute, VWAN), and GCP interconnectivity.
* **Network Automation (NetOps):** Python-based workflows using `Netmiko`, `Nornir`, and `Boto3` for automated switch/router configuration and state validation.
* **Configuration Management:** Enterprise Ansible Playbooks for compliance checks, OS upgrades, and Zero-Trust policy enforcement across hybrid nodes.
* **GitOps & Kubernetes:** Declarative deployments via Helm charts and GitOps CD pipelines.
* **Observability & Telemetry:** Datadog, Prometheus, and Grafana configurations for network flow log analysis and real-time operational metrics.

---

## Stack & Technologies

* **Infrastructure as Code:** Terraform, CloudFormation
* **Automation Frameworks:** Python (`Netmiko`, `Nornir`, `PyATS`), Ansible
* **Multi-Cloud:** AWS, Microsoft Azure, Google Cloud Platform
* **Routing & Security:** BGP, IPsec VPN, SD-WAN, ZTNA, Palo Alto, Fortinet
* **Observability:** Prometheus, Grafana, Wireshark, Datadog

---

## License
This repository is released under the [MIT License](LICENSE).
