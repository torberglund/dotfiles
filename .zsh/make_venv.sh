#!/usr/bin/env bash
set -euo pipefail

VENV_DIR=${1:-venv}
PYTHON_BIN=${PYTHON_BIN:-python3}
REQUIREMENTS_FILE=${REQUIREMENTS_FILE:-requirements.txt}

# 1. Check Python availability
if [[ ! -x "$(command -v "$PYTHON_BIN")" ]]; then
  echo "❌ Python interpreter '$PYTHON_BIN' not found." >&2
  exit 1
fi

# 2. Create venv if missing
if [[ ! -d "$VENV_DIR" ]]; then
  "$PYTHON_BIN" -m venv "$VENV_DIR"
  echo "✅ Created virtual environment at '$VENV_DIR'"
fi

# 3. Activate the venv in this shell
# (so pip installs go *inside* it, avoiding PEP 668 errors)
source "$VENV_DIR/bin/activate"

# 4. Upgrade pip safely (inside venv)
python -m pip install --upgrade pip

# 5. Install requirements if present
if [[ -f "$REQUIREMENTS_FILE" ]]; then
  pip install -r "$REQUIREMENTS_FILE"
else
  echo "⚠️ Requirements file '$REQUIREMENTS_FILE' not found; skipping install." >&2
fi

echo
echo "🎉 Virtual environment ready at '$VENV_DIR'"
echo "👉 To activate it later: source $VENV_DIR/bin/activate"
