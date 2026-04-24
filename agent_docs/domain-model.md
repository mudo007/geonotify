# Domain model

_Entities and value objects are added here as they are defined with TDD in sessions 5–6._

## Bounded contexts

### User context
Owns user identity and device registration (FCM token).

### Promotion context
Owns promotion definition, geo-fence rules, and validity windows.

### Notification context
Owns notification lifecycle: created → dispatched → delivered → failed.

## Entities (to be filled in during session 5)

### User
- Fields: TBD
- Invariants: TBD

### Promotion
- Fields: TBD
- Invariants: TBD

### Notification
- Fields: TBD
- Invariants: TBD

## Value objects (to be filled in during session 5)

### GeoCoordinate
- Lat/lng with validation bounds
- Immutable

### PromotionRadius
- Meters, minimum 50m, maximum 50km

## Repository interfaces

Interfaces live in domain packages.
Implementations live in `internal/adapters/postgres/`.

```go
// Defined in internal/domain/notification/repository.go
type Repository interface {
    Save(ctx context.Context, n *Notification) error
    FindByID(ctx context.Context, id uuid.UUID) (*Notification, error)
    FindPendingByUserID(ctx context.Context, userID uuid.UUID) ([]*Notification, error)
}
```

## Domain events

_Fill in during session 9._

| Event | Producer | Consumer |
|---|---|---|
| PromoEntered | geo-service | notification-service |
| NotificationDispatched | notification-service | (audit log) |