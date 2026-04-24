# geonotify — AI agent context

Geo-localization based push notification system built in Go with Apache Kafka.
Portfolio project demonstrating hexagonal architecture, TDD, observability, and
trunk-based CI/CD. Built as a deliberate AI-assisted development showcase.

## Quick orientation

- Language: Go 1.23+
- Architecture: Hexagonal (ports & adapters) with DDD vocabulary
- Event backbone: Apache Kafka 3.x (KRaft mode, no Zookeeper)
- Database: PostgreSQL 16
- Infra: GKE via Pulumi (Go), self-hosted Kafka on Kubernetes via Strimzi
- Dev environment: Docker only — nothing runs locally except Docker

## Commands (all via Make — never run Go or Docker directly)

- `make up` — start full stack (Go hot-reload, Postgres, Kafka, Kafka UI)
- `make down` — stop and remove containers
- `make test` — run tests inside container (includes -race flag)
- `make lint` — run golangci-lint inside container
- `make build` — compile check inside container
- `make shell-app` — shell into the app container

## Architecture rules (non-negotiable)

- `internal/domain/` never imports from `internal/adapters/` — dependency arrow points inward
- `cmd/api/main.go` is wiring only — no business logic
- Repository interfaces are defined in domain packages, implemented in adapters
- All errors are wrapped with context using `fmt.Errorf("operation: %w", err)`
- No naked `panic()` outside of main bootstrap

## Before making changes, read

- [Architecture overview](agent_docs/architecture.md)
- [Domain model](agent_docs/domain-model.md)
- [Testing patterns](agent_docs/testing-patterns.md)
- [Kafka conventions](agent_docs/kafka-conventions.md)
- [CI/CD and deployment](agent_docs/cicd.md)

## AI workflow guardrails

This project explicitly documents human-AI collaboration decisions.
Before generating significant code, check [agent_docs/ai-decisions.md](agent_docs/ai-decisions.md)
to understand which decisions are human-owned vs AI-assisted.