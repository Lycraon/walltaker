#!/usr/bin/env bash
set -euo pipefail

export COMMIT_HASH="$(git rev-parse HEAD)"
export RELEASE_CREATED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

exec "$@"