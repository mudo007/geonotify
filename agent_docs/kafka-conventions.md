# Kafka conventions

## Cluster setup

- Mode: KRaft (no Zookeeper) — Kafka 3.9.0
- Dev: single broker via docker compose
- GKE: single broker via Strimzi operator (session 17)
- Replication factor: 1 (dev/demo — increase for production)

## Topic naming convention
{domain}.{entity}.{event-type}
Examples:
geo.fence.entered
promotion.viewed
notification.dispatched
notification.failed

## Message envelope (all topics use this shape)

```go
type Event struct {
    ID          uuid.UUID       `json:"id"`           // event ID, for idempotency
    Type        string          `json:"type"`         // mirrors topic name
    OccurredAt  time.Time       `json:"occurred_at"`
    Payload     json.RawMessage `json:"payload"`      // domain-specific body
}
```

## Producer conventions

- Producers live in `internal/adapters/kafka/`
- Key = entity ID (ensures ordering per entity)
- Acks = "all" in production, "1" in dev
- Producer interface is defined in domain — adapter implements it

## Consumer conventions

- Consumers live in `internal/ports/kafka/`
- Consumer group naming: `geonotify.{service-name}`
- Idempotency: every handler checks event ID before processing
- Failed messages go to dead letter topic: `{original-topic}.dlq`

## Topics (fill in as built during sessions 9–12)

| Topic | Producer | Consumer | DLQ |
|---|---|---|---|
| geo.fence.entered | geo-service | notification-service | geo.fence.entered.dlq |
| notification.dispatched | notification-service | — | — |

## Local inspection

Kafka UI runs at http://localhost:8081 during `make up`.
Use it to inspect messages, consumer lag, and topic metadata.