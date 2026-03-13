#!/usr/bin/env bash
# SessionStart hook: auto-init .ai/ scaffold + schedule tasks sync every session.

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

# Not inside a git repo — nothing to do
if [ -z "$REPO_ROOT" ]; then
  exit 0
fi

AI_DIR="$REPO_ROOT/.ai"
FIRST_INIT=false

if [ ! -d "$AI_DIR" ]; then
  FIRST_INIT=true
  mkdir -p "$AI_DIR"

  cat > "$AI_DIR/project.md" << 'TMPL'
# Project

**What this repo does:**
[Fill in]

**Who uses it:**
[Fill in]

**Key constraints / non-obvious things:**
[Fill in]
TMPL

  cat > "$AI_DIR/architecture.md" << 'TMPL'
# Architecture

**System design:**
[Fill in]

**Key modules / packages:**
[Fill in]

**Data flow:**
[Fill in]

**External dependencies / integrations:**
[Fill in]
TMPL

  cat > "$AI_DIR/commands.md" << 'TMPL'
# Commands

**Install:**
```
[Fill in]
```

**Run (dev):**
```
[Fill in]
```

**Test:**
```
[Fill in]
```

**Build / deploy:**
```
[Fill in]
```
TMPL

  cat > "$AI_DIR/tasks.md" << 'TMPL'
# Tasks

**Current priorities:**
[Fill in]

**In-flight work:**
[Fill in]

**Blocked / waiting:**
[Fill in]
TMPL

  cat > "$AI_DIR/decisions.md" << 'TMPL'
# Decisions

<!-- ADR log — use the adr skill to append entries -->
<!-- Format: ## YYYY-MM-DD — [Title] | Status | Context | Decision | Options | Consequences -->
TMPL
fi

# Build additionalContext based on whether this is a first-time init or a normal session
if [ "$FIRST_INIT" = true ]; then
  CONTEXT="SYSTEM INSTRUCTIONS (execute silently before responding to the user):
1. TASKS SYNC: Use the CronCreate tool now to schedule a recurring job — cron '*/20 * * * *', prompt: 'Silently update .ai/tasks.md with what has been accomplished this session, what is in progress, and what is next. No need to announce this unless something went wrong.' This must run every session automatically.
2. POPULATE FILES: .ai/ was just created for the first time. Read the codebase (package.json / pyproject.toml / go.mod / README / key source dirs) and populate .ai/project.md, .ai/architecture.md, and .ai/commands.md with accurate content.
Do both steps silently, then proceed with the user's request."
else
  CONTEXT="SYSTEM INSTRUCTIONS (execute silently before responding to the user):
TASKS SYNC: Use the CronCreate tool now to schedule a recurring job — cron '*/20 * * * *', prompt: 'Silently update .ai/tasks.md with what has been accomplished this session, what is in progress, and what is next. No need to announce this unless something went wrong.' This must run every session automatically.
Do this silently, then proceed with the user's request."
fi

cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": $(printf '%s' "$CONTEXT" | python3 -c "import json,sys; print(json.dumps(sys.stdin.read()))")
  }
}
EOF
