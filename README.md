# ☸️ Advanced k8s Script Generator
> **Deploy scalable container workloads. Orchestrate deployment sets, load-balancing discovery service rules, ingress path routes, and pod autoscaling configurations dynamically in YAML manifests.**

[![Studio](https://img.shields.io/badge/Developer_Studio-Live-brightgreen)](https://pradeeptalari14.github.io/portfolio/tools/kubernetes/)
[![Category](https://img.shields.io/badge/Category-cloud-blue)]()

---

## 🎛️ Studio Options — What the UI Generates

The studio has multiple configurable options. Each combination produces different output files.
This repository contains **one working example per option variant** so you can learn by diffing.

### Output Tabs (files the studio generates)
| Tab | Description |
|-----|-------------|
| `deployment.yaml` | Generated in studio Output tab |
| `service.yaml` | Generated in studio Output tab |
| `ingress.yaml` | Generated in studio Output tab |
| `hpa.yaml` | Generated in studio Output tab |
| `Flow Diagram` | Generated in studio Output tab |

### Configurable Options
| Option | Available Values |
|--------|-----------------|
| **Workload Type** | `Deployment` / `StatefulSet` / `DaemonSet` |
| **Cloud Provider** | `AWS EKS` / `GCP GKE` / `Azure AKS` |
| **Service Type** | `ClusterIP` / `NodePort` / `LoadBalancer` |
| **Ingress** | `enabled` / `disabled` |
| **HPA** | `enabled` / `disabled` |
| **RBAC** | `enabled` / `disabled` |
| **NetworkPolicy** | `enabled` / `disabled` |
| **Security Hardening** | `enabled` / `disabled` |

---

## 🏗️ Architecture Flow Diagram

![SRE Architecture Flow](docs/sre_architecture_flow.png)

```mermaid
graph TD
  DEV[👩‍💻 Developer] -->|git push| CI[🔄 CI/CD Pipeline]
  CI -->|docker build + push| REG[📦 Container Registry]
  CI -->|kubectl apply| K8S[☸️ Kubernetes Cluster]
  K8S --> NS[📁 Namespace: production]
  NS --> DEP[📋 Deployment x3 pods]
  DEP --> HPA[📈 HPA: 2-10 replicas]
  DEP --> PDB[🛡️ PodDisruptionBudget]
  NS --> SVC[🌐 Service: ClusterIP]
  SVC --> ING[🔀 Ingress + TLS]
  NS --> NP[🔒 NetworkPolicy]
  DEP -->|/metrics| PROM[📊 Prometheus]
```

---

## 📁 Repository Structure

```
tp-kubernetes/
├── README.md          ← This file — complete learning guide
├── examples/deployment/deployment.yaml
├── examples/statefulset/statefulset.yaml
├── examples/daemonset/daemonset.yaml
├── examples/networking/service.yaml
├── examples/networking/ingress.yaml
├── examples/scaling/hpa.yaml
├── examples/security/rbac.yaml
├── examples/security/network-policy.yaml
├── examples/resilience/pdb.yaml
├── scripts/deploy.sh
├── scripts/           ← Deployment + validation helpers
└── docs/USAGE.md      ← Extended usage guide
```

---

## 🚀 Step-by-Step Onboarding & Validation Guide

Follow these SRE steps to deploy, validate, and monitor this repository's workspace configs in a local or production environment:

#### 1. Prerequisites
- [x] **Terraform 1.5+**
- [x] **Kubectl & Helm 3.0+**
- [x] **AWS CLI / Google Cloud SDK configured**

#### 2. Download
Clone this repository locally:
```bash
git clone https://github.com/Pradeeptalari14/tp-kubernetes.git
cd tp-kubernetes
```

#### 3. Install
Fetch required packages and compile environment binaries:
```bash
terraform init || helm repo add stable https://charts.helm.sh/stable
```

#### 4. Enable Automatic Sidecar Injection
Enforce AWS Secret Manager sidecars or HashiCorp Vault Agent sidecars to inject dynamic credentials into resources.

#### 5. Install Kubernetes Gateway API CRDs
Deploy Kubernetes Gateway API custom resource definitions (CRDs) for cross-service route rules:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.1.0/config/crd/standard/gateway-api-v1.1.0-experimental.yaml
```

#### 6. Deploy Application Workload
Apply Terraform templates or apply Kubernetes deployment manifests:
```bash
terraform plan -out=tfplan
terraform apply tfplan
# Or apply manifests
kubectl apply -f deploy/
```

#### 7. Validate Application Inside Cluster
Inspect resources state and check running pods inside the cluster:
```bash
terraform show && kubectl get all -n production
```

#### 8. Expose Application Using Gateway
Expose target load balancer ingress gateways or forward local ports:
```bash
kubectl port-forward deployment/tp-kubernetes 8080:8080
```

#### 9. Access the Application
Access service endpoints (printed in `terraform output`) or cluster local address [http://localhost:8080](http://localhost:8080).

#### 10. Install Addons
Install Karpenter autoscalers, AWS Load Balancer controllers, and ExternalDNS sync modules.

#### 11. Access Dashboard
Access EKS cloud dashboard, resource cost trackers, or local Kubernetes web consoles.

#### 12. View Service Mesh Graph
View resource dependencies diagram using `terraform graph` or inspect services topology structures.

#### 13. Generate Traffic
Inject test traffic loops to evaluate auto-scaling triggers:
```bash
kubectl run load-generator --image=busybox --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://tp-kubernetes; done"
```

#### 14. Project Structure
```text
tp-tp-kubernetes/
├── .gitignore                # Version control exclusions
├── LICENSE                   # MIT Open Source License
├── SECURITY.md               # Vulnerability reporting protocols
├── CHANGELOG.md              # Releases version history
├── README.md                 # Project learning guide & onboarding
├── .env.example              # Template parameters config
├── .pre-commit-config.yaml   # Gitleaks & lint pipeline hooks
├── docs/
│   ├── USAGE.md              # Extended developer usage docs
│   ├── TROUBLESHOOTING.md    # Failures resolution guide
│   ├── GLOSSARY.md           # SRE domain terminology index
│   ├── COMPLIANCE.md         # Legal and security checks checklist
│   └── sre_architecture_flow.png # Category SRE architecture diagram
├── scripts/
│   └── validate.sh           # Local validation helper script
└── .github/
    ├── CONTRIBUTING.md       # Contributing instructions
    ├── PULL_REQUEST_TEMPLATE.md # Pull request code compliance check
    ├── ISSUE_TEMPLATE/       # Bug and features tickets
    ├── dependabot.yml        # Auto updates dependencies
    └── workflows/
        └── security-scan.yml # Gitleaks/yamllint/shellcheck scans

# Primary Config File: deployment.yaml
```

#### 15. Observability Components
Tracks cloud resource consumption metrics: node auto-scaling stats, CPU/Memory limit pools, and network requests.

#### 16. Install Monitoring
Triggers cloud alerts on cost budget breaches, node terminations, or replication failures.

---

## 📖 How Each Option Changes the Output

### Workload Type
- **`Deployment`** — see `examples/` folder for generated output
- **`StatefulSet`** — see `examples/` folder for generated output
- **`DaemonSet`** — see `examples/` folder for generated output

### Cloud Provider
- **`AWS EKS`** — see `examples/` folder for generated output
- **`GCP GKE`** — see `examples/` folder for generated output
- **`Azure AKS`** — see `examples/` folder for generated output

### Service Type
- **`ClusterIP`** — see `examples/` folder for generated output
- **`NodePort`** — see `examples/` folder for generated output
- **`LoadBalancer`** — see `examples/` folder for generated output

### Ingress
- **`enabled`** — see `examples/` folder for generated output
- **`disabled`** — see `examples/` folder for generated output

### HPA
- **`enabled`** — see `examples/` folder for generated output
- **`disabled`** — see `examples/` folder for generated output

### RBAC
- **`enabled`** — see `examples/` folder for generated output
- **`disabled`** — see `examples/` folder for generated output

### NetworkPolicy
- **`enabled`** — see `examples/` folder for generated output
- **`disabled`** — see `examples/` folder for generated output

### Security Hardening
- **`enabled`** — see `examples/` folder for generated output
- **`disabled`** — see `examples/` folder for generated output

---

## 💡 SRE Compliance & Best Practices

| SRE Compliance Pillar | ❌ Anti-Pattern | ✅ Production Best Practice |
|---|---|---|
| **Secrets Protection** | Committing passwords or dynamic tokens to repositories | Exclude sensitive files in `.gitignore` and reference Vault parameters |
| **Deployment Auditing** | Manual ad-hoc server updates | Enforce infrastructure validation and continuous deployment pipelines |

## 🔐 Security Standards

- ❌ Never commit credentials, API keys, or database passwords directly to Git repositories.
- ✅ Reference dynamic parameters using cloud Secret Managers (Vault, AWS SSM Parameter Store, Key Vault).
- ✅ Enforce branch protection rules: require peer pull request reviews and green status checks.

---

## 📖 Resources

| Resource | Link |
|----------|------|
| Interactive Studio | [Open →](https://pradeeptalari14.github.io/portfolio/tools/kubernetes/) |
| All 91 Studios | [Dashboard →](https://pradeeptalari14.github.io/portfolio/tools/) |
| SRE Provisioning Guide | [Handbook →](https://github.com/Pradeeptalari14/portfolio/blob/main/GITHUB_PROVISIONING_GUIDE.md) |

---
*Generated by [Advanced k8s Script Generator Studio](https://pradeeptalari14.github.io/portfolio/tools/kubernetes/) — [Talari Pradeep Portfolio](https://pradeeptalari14.github.io/portfolio)*