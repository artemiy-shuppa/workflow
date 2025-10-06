#!/usr/bin/env bash

set -euo pipefail # Strict mode by default

set +e # Temporary disable exit-on-error

# capture both stdout and stderr
RUFF_OUTPUT=$(ruff check . 2>&1)
RUFF_EXIT=$?

PYRIGHT_OUTPUT=$(pyright 2>&1)
PYRIGHT_EXIT=$?

set -e # Bring back exit-on-error

echo "========================================="
echo "LINTING: ruff check ."
echo "========================================="
echo "${RUFF_OUTPUT}"
echo
echo "========================================="
echo "LINTING: pyright"
echo "========================================="
echo "${PYRIGHT_OUTPUT}"
echo

if [ $RUFF_EXIT -ne 0 ] || [ $PYRIGHT_EXIT -ne 0 ]; then
  echo "❌ Result: FAILED"
  echo "   Ruff exit code: $RUFF_EXIT"
  echo "   Pyright exit code: $PYRIGHT_EXIT"
  exit 1
else
  echo "✅ Result: SUCCESS"
  exit 0
fi
