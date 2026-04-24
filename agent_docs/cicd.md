# CI/CD and deployment

## Branching strategy: trunk-based development

- `main` is always deployable
- Feature work in short-lived branches (< 2 days)
- No long-lived feature branches
- Feature flags over feature branches for incomplete work

## Local CI
- Uses versioned .githooks/pre-commit to run linting locally before commits

## CI pipeline (GitHub Actions)

Triggers: every push to any branch, every PR to main.

Stages in order:
1. `lint` — golangci-lint, fail fast
2. `test` — go test ./... -race -count=1
3. `build` — go build, confirms it compiles

_Add Docker build + push to Artifact Registry in session 17._
_Add GKE deploy step in session 18._

## DORA metrics (built-in from session 8)

| Metric | How we measure it |
|---|---|
| Deployment frequency | GitHub Actions deployment events → Grafana |
| Lead time for changes | PR open → deploy timestamp delta |
| Change failure rate | Failed deployments / total deployments |
| MTTR | Incident open → resolved timestamp (manual for now) |

Grafana dashboard added in session 16.

## IaC: Pulumi + Go

- Provider: Google Cloud (GKE, Artifact Registry, Cloud SQL)
- Language: Go (same language as app — no context switching)
- State: Pulumi Cloud (free tier)
- Location: `deployments/pulumi/`

_Bootstrapped in session 4, extended in session 17._

## Deployment targets

| Environment | Trigger | Cluster |
|---|---|---|
| dev | `make up` | docker compose, local |
| staging | merge to main | GKE, auto |
| production | manual promote | GKE, gated |

_Staging and production added in sessions 17–18._

## Secrets management

- Dev: `.env` file (gitignored), loaded by docker compose
- GKE: Kubernetes secrets managed by Pulumi
- Never commit secrets. `.env.example` documents required vars with fake values.

## Required environment variables

See `.env.example` at repo root.