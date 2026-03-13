# Claude Code — Global Instructions (ON24 Team Template)

## Operating Model

**Plan → Execute → Verify → Learn**

| Phase | Default | Trigger |
|---|---|---|
| Plan | Write a spec before building | Any non-trivial task (3+ steps or architectural decisions) |
| Execute | Keep main context clean | Subagents for research/exploration/parallel work |
| Verify | Prove it works before "done" | Always; especially after refactors or behavior changes |
| Learn | Encode the lesson | After any correction or recurring mistake |

---

## Plan First
- Enter **plan mode** for any non-trivial task (3+ steps or architectural decisions).
- If execution deviates or something breaks: stop and re-plan immediately.
- Use plan mode for **verification strategy**, not just build steps.
- Write **detailed specs upfront** to reduce ambiguity.

---

## Subagent Strategy
- Use subagents liberally to keep the **main context clean**.
- Offload: research, exploration, parallel analysis.
- **One task per subagent** for focused execution.

---

## Commit & Docs Cadence
- After every logical chunk of work (a feature, a fix, a refactor): git commit.
- After committing: update `.ai/tasks.md` and `.ai/decisions.md` if relevant.
- When context reveals something worth preserving across sessions: update `memory/` files.
- Git is durable memory. Chat is not.

---

## Architecture Decisions (ADR Workflow)
Before any significant technical decision:
1. Document in `.ai/decisions.md`: **date | decision | context | options considered | consequences**
2. Keep it short — 5–10 lines max per entry.
3. If a decision is later reversed, add a follow-up entry (don't delete the original).

Use the `adr` skill for guided ADR generation.

---

## Product Workflow (PRD → Spec → Plan)
For any new feature or product change:
1. **PRD first**: problem statement, user persona, success criteria, out-of-scope
2. **Acceptance criteria**: concrete, testable conditions
3. **Then** enter plan mode for implementation

Use the `prd` skill for guided PRD creation, then `/feature-dev` for implementation.

---

## Verification Before Done
- Never mark complete without **demonstrating correctness**.
- Run tests, check logs, diff behavior vs. baseline where relevant.
- Gate question: **"Would a staff engineer approve this?"**

---

## Elegance (Balanced)
- For non-trivial changes: ask "Is there a more elegant way?"
- If a fix feels hacky: redesign using current knowledge.
- Avoid over-engineering for obvious/simple fixes.

---

## Autonomous Bug Fixing
- Fix it — no user context-switching needed for diagnosed bugs.
- Path: logs → errors → failing tests → root cause.
- Proactively fix failing CI where applicable.

---

## Core Principles

### Simplicity First
- Make every change as simple as possible. Touch minimal code.
- Don't add features, refactors, comments, or type annotations beyond what was asked.
- Don't design for hypothetical future requirements.

### Safety Rules
- Never force-push main/master without explicit confirmation.
- Never skip pre-commit hooks without explicit request.
- Never delete files, branches, or database entries without confirmation.
- Never commit .env, credentials, or secrets.

### Minimal Impact
- Only modify what's required. Avoid introducing new bugs.
- Ask for minimal feedback. Decide and execute unless truly ambiguous.

---

## Stack Defaults
<!-- CUSTOMIZE THIS SECTION for your team's tech stack -->
- **AI/LLM:** claude-sonnet-4-6 (main), claude-haiku-4-5-20251001 (fast/cheap tasks)
- **Language:** [e.g. Python 3.11+, TypeScript 5+]
- **Framework:** [e.g. FastAPI, React, Next.js]
- **Package mgr:** [e.g. pnpm preferred, npm acceptable]
- **Testing:** [e.g. pytest, Jest, Vitest]
- **Validation:** Always at system boundaries; trust internal code

---

## Compaction Rules
- Bullets over prose. No verbatim log dumps.
- Small diffs over full rewrites.
- Quiet commands: pytest -q, npm i --silent, pnpm -s.
- Targeted git: git diff <file> not git diff.

---

## Repo Memory Pattern
Treat the repo as durable memory; chat is temporary.
Persist important context in:

- .ai/project.md — overview
- .ai/architecture.md — design/modules
- .ai/commands.md — how to run
- .ai/tasks.md — current priorities
- .ai/decisions.md — ADR log

---

## MCP Servers
<!-- CUSTOMIZE: Add your org's MCP server connections here -->
- **GitLab:** add via Claude Code MCP settings — type: http, url https://gitlab.com/api/v4/mcp, requires GITLAB_PERSONAL_ACCESS_TOKEN env var

---

## Output Format
Default: (1) plan, (2) minimal diff/snippet, (3) exact commands to run, (4) what success looks like.
