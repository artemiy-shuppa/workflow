#!/usr/bin/env bash

set -euo pipefail # Strict mode by default

OUTPUT_FILE="${1:-}"

set +e # Temporary disable exit-on-error

# capture both stdout and stderr
RUFF_OUTPUT=$(ruff check . 2>&1)
RUFF_EXIT=$?

PYRIGHT_OUTPUT=$(pyright 2>&1)
PYRIGHT_EXIT=$?

set -e # Bring back exit-on-error

REPORT=$(
  cat <<EOF
=========================================
LINTING: ruff check ."
=========================================
${RUFF_OUTPUT}"

=========================================
LINTING: pyright"
=========================================
${PYRIGHT_OUTPUT}"
EOF
)

if [ $RUFF_EXIT -ne 0 ] || [ $PYRIGHT_EXIT -ne 0 ]; then
  echo "❌ Result: FAILED"
  echo "   Ruff exit code: $RUFF_EXIT"
  echo "   Pyright exit code: $PYRIGHT_EXIT"
  exit 1
else
  echo "✅ Result: SUCCESS"
  exit 0
fi
