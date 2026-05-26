#!/bin/bash
set -euo pipefail
ENV_FILE="${1:-/root/projects/mindvault-client-portal/.env}"
HTML="/root/projects/mindvault-client-portal/index.html"

if [ ! -f "$ENV_FILE" ]; then
  echo "Missing env file: $ENV_FILE"
  echo "Create it with: CLERK_PUBLISHABLE_KEY=pk_test_..."
  exit 1
fi

set -a
. "$ENV_FILE"
set +a

KEY="${CLERK_PUBLISHABLE_KEY:-${NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY:-${VITE_CLERK_PUBLISHABLE_KEY:-}}}"
if [ -z "$KEY" ]; then
  echo "No Clerk publishable key found. Expected one of:"
  echo "  CLERK_PUBLISHABLE_KEY"
  echo "  NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY"
  echo "  VITE_CLERK_PUBLISHABLE_KEY"
  exit 1
fi

python3 - <<PY
from pathlib import Path
import os, re
p=Path('$HTML')
s=p.read_text()
key=os.environ['KEY'] if 'KEY' in os.environ else '''$KEY'''
s=re.sub(r"const CLERK_PUBLISHABLE_KEY='[^']*';", "const CLERK_PUBLISHABLE_KEY='"+key+"';", s)
p.write_text(s)
PY

echo "Injected Clerk publishable key into $HTML"
