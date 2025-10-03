# takione-infra

> Infrastructure as Code pour le déploiement complet de la plateforme **Takione** sur AWS, avec une approche GitOps et CI/CD automatisée.

---

## 🚀 Objectif

Ce dépôt contient le code Terraform permettant de provisionner l'infrastructure AWS pour héberger une stack applicative Kubernetes multi-environnements (**staging** et **production**), compatible avec des workflows GitOps (ArgoCD / FluxCD) et des outils CI/CD (GitLab CI).

---

## 🔧 Stack technique

| Composant        | Usage                                      |
|------------------|--------------------------------------------|
| Terraform        | Provisionnement AWS (VPC, EC2, etc.)       |
| AWS              | Cloud provider principal                   |
| GitLab CI/CD     | Pipelines d’automatisation                 |
| Helm             | Déploiement applicatif sur Kubernetes      |
| Kubernetes       | Orchestration des services (EKS ou custom) |
| ArgoCD (option)  | GitOps pour synchronisation déclarative    |

---

## 📁 Structure du projet

```
takione-infra/
├── terraform/
│   ├── main.tf
│   ├── aws.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── network/, compute/, secrets/...
├── .gitlab-ci.yml
├── README.md
└── LICENSE.md
```

---

## 🌍 Environnements supportés

- **Staging** : configuration via `values.staging.yaml` (voir dépôt `takione-apps`)
- **Production** : configuration via `values.prod.yaml`

Chaque environnement est isolé avec son propre namespace Kubernetes, sa propre configuration réseau, et son propre backend Terraform (via `workspace`).

---

## 🛠️ Déploiement (extrait simplifié)

```bash
cd terraform
terraform init
terraform workspace select staging || terraform workspace new staging
terraform apply -var-file=vars/staging.tfvars
```

---

## 📦 Déploiement applicatif

Les charts Helm sont disponibles dans le dépôt complémentaire [`takione-apps`](https://github.com/logo-solutions/takione-apps).

---

## 🧩 Diagramme d’architecture

> *(à insérer dans le dépôt : `docs/architecture.png`)*  
> Inclure un diagramme illustrant les composants AWS provisionnés : VPC, EC2/EKS, security groups, etc.

---

## 📜 Licence

Ce dépôt est publié sous licence [AGPLv3](LICENSE.md).  
Toute amélioration ou réutilisation doit être partagée en open-source.

---

## ✉️ Contact

Pour toute question, contactez-moi à : **loic@logo-solutions.fr**

