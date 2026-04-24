.PHONY: up down logs test lint build shell-app shell-db

# Start the full stack
up:
	docker compose up --build -d

# Stop and remove containers
down:
	docker compose down -v

# Follow logs
logs:
	docker compose logs -f

# Run all tests inside the app container
test:
	docker compose run --rm app go test ./... -v -race -count=1

# Run linter inside the app container  
lint:
	docker compose run --rm app golangci-lint run ./...

# Build the binary
build:
	docker compose run --rm app go build -o /dev/null ./...

# Shell into the app container
shell-app:
	docker compose exec app sh

# Shell into postgres
shell-db:
	docker compose exec postgres psql -U geonotify -d geonotify