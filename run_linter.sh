#!/bin/bash

# Run golangci-lint to check for issues
echo "Running golangci-lint..."
golangci-lint run ./...