#!/bin/bash
# SessionStart hook: makes sure the CLIs backing this repo's skills
# (graphify, agent-browser) are on PATH for the session. Best-effort —
# never blocks or fails session startup, and is a fast no-op once
# both tools are already installed (e.g. a cached container).
set -uo pipefail

# uv tool installs (graphify) land outside the default PATH; resolve the
# real bin dir when uv is available, else assume the standard default.
UV_BIN_DIR="$HOME/.local/bin"
if command -v uv >/dev/null 2>&1; then
    resolved="$(uv tool dir --bin 2>/dev/null || true)"
    [ -n "$resolved" ] && UV_BIN_DIR="$resolved"
fi

# Persist it for the interactive session, and pick it up here too so the
# command -v checks below see a tool installed in a prior run.
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
    echo "export PATH=\"$UV_BIN_DIR:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi
export PATH="$UV_BIN_DIR:$PATH"

# --- graphify: knowledge-graph skill (.claude/skills/graphify) ---
if ! command -v graphify >/dev/null 2>&1; then
    if command -v uv >/dev/null 2>&1; then
        uv tool install graphifyy -q >/dev/null 2>&1 \
            || echo "session-start: graphify install failed, skipping" >&2
    elif command -v pip3 >/dev/null 2>&1; then
        pip3 install --user graphifyy -q >/dev/null 2>&1 \
            || pip3 install --user graphifyy -q --break-system-packages >/dev/null 2>&1 \
            || echo "session-start: graphify install failed, skipping" >&2
    else
        echo "session-start: no uv/pip found, skipping graphify install" >&2
    fi
fi

# --- agent-browser: browser-automation skill (.claude/skills/agent-browser) ---
if ! command -v agent-browser >/dev/null 2>&1; then
    if command -v npm >/dev/null 2>&1; then
        npm install -g agent-browser --silent >/dev/null 2>&1 \
            || echo "session-start: agent-browser install failed, skipping" >&2
    else
        echo "session-start: no npm found, skipping agent-browser install" >&2
    fi
fi

exit 0
