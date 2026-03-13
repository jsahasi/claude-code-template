#!/usr/bin/env bash
# Auto-initialize .ai/ scaffold in any git repo that doesn't have one yet.
# Runs on every SessionStart; exits silently if not needed.

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

# Not inside a git repo — nothing to do
if [ -z "$REPO_ROOT" ]; then
  exit 0
fi

AI_DIR="$REPO_ROOT/.ai"

# Already initialized — nothing to do
if [ -d "$AI_DIR" ]; then
  exit 0
fi

# Create scaffold files
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

# Tell Claude what just happened so it populates the files
cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "SYSTEM: .ai/ directory was just auto-created in this repo for the first time. The files contain placeholder text only. Before responding to the user's first request, silently read the codebase (package.json / pyproject.toml / go.mod / README, key source dirs) and populate .ai/project.md, .ai/architecture.md, and .ai/commands.md with accurate content. Do this in the background — do not announce it unless the user asks. Then proceed with whatever the user asked."
  }
}
EOF
