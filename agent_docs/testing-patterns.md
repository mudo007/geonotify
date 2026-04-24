# Testing patterns

## Philosophy

Tests are the safety net that makes refactoring possible.
No test, no merge. This is non-negotiable.

## Test layout

Tests live next to the code they test.
internal/domain/notification/
notification.go
notification_test.go      ← unit test, no external deps
internal/adapters/postgres/
repository.go
repository_test.go        ← integration test, uses real Postgres

## Test categories and tags

```go
//go:build unit
// unit tests: pure domain logic, no I/O, fast

//go:build integration
// integration tests: real Postgres, real Kafka, use testcontainers
```

Run selectively:
```bash
make test-unit          # fast, runs on every save
make test-integration   # slower, runs in CI and before PR
```

_Add make targets during session 5._

## Unit test pattern (domain layer)

```go
func TestNotification_MarkDispatched(t *testing.T) {
    t.Parallel()

    n := notification.New(userID, promotionID)
    assert.Equal(t, notification.StatusPending, n.Status)

    err := n.MarkDispatched()

    assert.NoError(t, err)
    assert.Equal(t, notification.StatusDispatched, n.Status)
    assert.NotZero(t, n.DispatchedAt)
}
```

## Integration test pattern (adapter layer)

Uses testcontainers-go — no mocks for infrastructure, real containers.

```go
func TestPostgresRepository_Save(t *testing.T) {
    ctx := context.Background()
    repo := setupTestRepo(t, ctx)   // spins up postgres container

    n := notification.New(testUserID, testPromoID)
    err := repo.Save(ctx, n)

    assert.NoError(t, err)
    // fetch and assert roundtrip
}
```

## What we never mock

- Domain logic (test it directly)
- Postgres in integration tests (use testcontainers)
- Kafka in integration tests (use testcontainers)

## What we do mock

- FCM push adapter (external HTTP call — use interface + fake in tests)
- Clock (inject time.Now as a dependency for deterministic tests)