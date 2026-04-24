#!/bin/sh
# Run tidy to ensure go.sum exists on the host mount
go mod tidy
go mod download
# Execute the main container command (the CMD from Dockerfile)
exec "$@"