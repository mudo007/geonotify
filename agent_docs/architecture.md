# Architecture overview

## Style: hexagonal (ports & adapters) with DDD vocabulary

The dependency rule is absolute: dependencies point inward.
Outer layers know about inner layers. Inner layers know nothing about outer layers.

## Layer map
cmd/api/main.go          — composition root. Wires everything. Zero logic.
internal/domain/         — pure Go. No framework imports. No DB. No HTTP.
internal/ports/http/     — HTTP handlers. Thin: validate → domain → respond.
internal/ports/kafka/    — Kafka consumers. Thin: deserialize → domain → respond.
internal/adapters/postgres/ — implements repository interfaces from domain.
internal/adapters/kafka/    — Kafka producer implementation.
internal/adapters/push/     — FCM push notification implementation.
pkg/                     — shared utilities. No business logic.
deployments/             — Docker, Kubernetes, Pulumi IaC.

## Dependency rule enforced by linter

No import of `internal/adapters/*` from `internal/domain/*` — ever.
Violated imports will fail `make lint`.

## Key patterns in use

- Repository pattern: interfaces in domain, implementations in adapters
- Dependency injection: constructor injection only, no globals
- Domain events: notifications are triggered by domain events, not direct calls
- Value objects: geo-coordinates, promotion radius are value objects with validation

## Services and their responsibilities

_Fill in as services are built from session 5 onward._

| Service | Responsibility | Kafka topics owned |
|---|---|---|
| promotion-service | TBD | TBD |
| notification-service | TBD | TBD |
| geo-service | TBD | TBD |

## Data flow (happy path)

_Fill in during session 9._
User enters geo-fence → geo-service produces event → Kafka →
notification-service consumes → push adapter → FCM → user phone