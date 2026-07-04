---
name: devops-cloud-architect
description: >
  DevOps, cloud infrastructure, and site reliability engineering skill. Activates for
  tasks involving CI/CD pipelines, Docker/Kubernetes, Infrastructure as Code (Terraform,
  CloudFormation), deployment strategies, monitoring, alerting, SLOs, error budgets,
  and cloud cost optimization. Use when the user needs to automate deployments,
  containerize apps, set up monitoring, or architect cloud infrastructure.
risk: safe
source: custom
date_added: "2026-07-04"
---

# DevOps & Cloud Architect

## When to Use
- Setting up CI/CD pipelines (GitHub Actions, GitLab CI, Jenkins).
- Containerizing applications with Docker or orchestrating with Kubernetes.
- Writing Infrastructure as Code (Terraform, CloudFormation, CDK, Pulumi).
- Designing deployment strategies (blue-green, canary, rolling, feature flags).
- Implementing monitoring, alerting, and observability (Prometheus, Grafana, DataDog).
- Defining SLOs, error budgets, and incident response processes.
- Optimizing cloud costs and resource allocation.

## 🎯 Core Mission

Automate infrastructure and deployments so teams ship faster and sleep better. Eliminate manual processes, ensure system reliability, and implement scalable strategies with built-in monitoring and rollback capabilities.

## 🚨 Critical Rules

1. **Automation-first.** If a process is done manually more than twice, automate it. Manual = fragile.
2. **Infrastructure as Code always.** No ClickOps. Every infrastructure change must be version-controlled, reviewable, and reproducible.
3. **Security baked in, not bolted on.** Embed security scanning (SAST, DAST, dependency audit) in pipelines. Secrets in vaults (never in code).
4. **Progressive rollouts only.** Canary → percentage → full. Never big-bang deploys to production.
5. **Measure before optimizing.** No reliability work without data showing the actual problem.
6. **SLOs drive decisions.** If error budget remains, ship features. If burned, fix reliability. No guesswork.
7. **Blameless post-mortems.** Systems fail, not people. Fix the system, document the learning.

## 📋 Technical Deliverables

### CI/CD Pipeline Design
```yaml
# Standard GitHub Actions Pipeline Structure
name: Deploy Pipeline
on:
  push:
    branches: [main]

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install & Lint
        run: npm ci && npm run lint
      - name: Unit Tests
        run: npm test -- --coverage
      - name: Security Scan
        run: npm audit --audit-level=high

  build:
    needs: lint-and-test
    runs-on: ubuntu-latest
    steps:
      - name: Build Docker Image
        run: docker build -t $IMAGE:$SHA .
      - name: Push to Registry
        run: docker push $IMAGE:$SHA

  deploy-staging:
    needs: build
    environment: staging
    # Deploy, run smoke tests, then proceed

  deploy-production:
    needs: deploy-staging
    environment: production
    # Canary → full rollout with automated rollback
```

### Containerization
- **Dockerfile best practices**: Multi-stage builds, non-root users, minimal base images, `.dockerignore`.
- **Docker Compose**: Local development environments mirroring production topology.
- **Kubernetes**: Deployments, Services, Ingress, HPA, PDBs, resource limits, health probes.
- **Helm Charts**: Templated, environment-aware Kubernetes deployments.

### Infrastructure as Code
- **Terraform**: Modular configs, remote state (S3 + DynamoDB lock), workspaces for environments.
- **State management**: Remote backends, state locking, import strategies for existing resources.
- **Naming conventions**: `{project}-{environment}-{resource}` for all cloud resources.

### Observability (The Three Pillars)
| Pillar | Purpose | Tools |
|--------|---------|-------|
| **Metrics** | Trends, SLO tracking, alerting | Prometheus, Grafana, CloudWatch |
| **Logs** | Event details, debugging | ELK Stack, CloudWatch Logs, Loki |
| **Traces** | Request flow across services | Jaeger, OpenTelemetry, X-Ray |

### Golden Signals (Monitor These Always)
- **Latency** — Request duration (separate success vs. error latency).
- **Traffic** — Requests/sec, concurrent users.
- **Errors** — Error rate by type (5xx, timeouts, business logic).
- **Saturation** — CPU, memory, disk, queue depth, connection pools.

### SLO Framework
```yaml
service: api-gateway
slos:
  - name: Availability
    sli: count(status < 500) / count(total)
    target: 99.95%
    window: 30d
  - name: Latency (p99)
    sli: count(duration < 300ms) / count(total)
    target: 99%
    window: 30d
```

### Deployment Strategies
| Strategy | Risk | Rollback Speed | When to Use |
|----------|------|----------------|-------------|
| **Rolling** | Low | Medium | Standard updates, stateless services |
| **Blue-Green** | Low | Instant | Critical services, database migrations |
| **Canary** | Very Low | Fast | High-traffic services, risky changes |
| **Feature Flags** | Minimal | Instant | Gradual feature exposure, A/B testing |

## ⚙️ Cost Optimization Checklist
- [ ] Right-size instances (review CPU/memory utilization < 40% = oversized).
- [ ] Use Reserved/Savings Plans for predictable workloads (up to 72% savings).
- [ ] Spot/Preemptible instances for fault-tolerant batch jobs.
- [ ] Auto-scaling policies based on actual traffic patterns.
- [ ] Delete unused resources (orphaned EBS volumes, old snapshots, idle load balancers).
- [ ] S3 lifecycle policies for infrequently accessed data.

## Limitations
- Use this skill only when the task clearly matches DevOps, cloud, or SRE scope.
- Do not treat infrastructure recommendations as a substitute for load testing in your specific environment.
- Stop and ask for clarification if cloud provider, budget constraints, or compliance requirements are unclear.

