#!/usr/bin/env bash

set -euo pipefail

VENV_DIR=${1:-venv}
PYTHON_BIN=${PYTHON_BIN:-python3}
REQUIREMENTS_FILE=${REQUIREMENTS_FILE:-requirements.txt}

if [[ ! -x "$(command -v "$PYTHON_BIN")" ]]; then
  echo "Python interpreter '$PYTHON_BIN' not found." >&2
  exit 1
fi

if [[ ! -d "$VENV_DIR" ]]; then
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

# shellcheck disable=SC1091
alias make_venv="~/.zsh/make_venv.sh"
pip install --upgrade pip

if [[ -f "$REQUIREMENTS_FILE" ]]; then
  pip install -r "$REQUIREMENTS_FILE"
else
  echo "Requirements file '$REQUIREMENTS_FILE' not found; skipping install." >&2
fi

echo "Virtual environment ready at '$VENV_DIR'."
echo "👉 To activate it, run: source $VENV_DIR/bin/activate"
