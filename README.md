# ON24 Claude Code Configuration Template

Shared Claude Code configuration for the ON24 engineering team. Drop this folder as `~/.claude` to get a production-grade AI development environment in minutes.

## What's Included

| File/Dir | Purpose |
|---|---|
| `CLAUDE.md` | Global instructions loaded into every Claude session |
| `settings.json` | Tool permissions, output style, env knobs, enabled plugins |
| `policy-limits.json` | Security: disables remote control |
| `commands/` | Slash commands (`/prd`) |
| `skills/` | Custom skills (PRD creation) |
| `plugins/local/user-skills/` | Local plugin bundle (ADR skill) |
| `hooks-handlers/init-ai.sh` | SessionStart hook: auto-init `.ai/` + schedule tasks sync |

## Quick Start

See **ON24 Claude Code Onboarding Guide.docx** in this folder for full installation, configuration, and best-practices walkthrough.

**TL;DR:**
```bash
# 1. Back up existing config (if any)
mv ~/.claude ~/.claude.bak

# 2. Copy template
cp -r /path/to/.claude_on24template ~/.claude

# 3. Install plugins (downloads plugin cache)
claude plugin install superpowers
claude plugin install slack
claude plugin install ralph-loop
claude plugin install frontend-design
claude plugin install security-guidance

# 4. Customize ~/.claude/CLAUDE.md Stack Defaults section for your team
```

## CLAUDE.md Sections

- **Operating Model** — Plan > Execute > Verify > Learn
- **Subagent Strategy** — Offload research/exploration to keep main context clean
- **Product Workflow** — PRD → Spec → Plan → Implement with skill guidance
- **ADR Workflow** — Document architecture decisions before making them
- **Core Principles** — Simplicity, safety, minimal impact
- **Stack Defaults** — ⚠️ Customize this section for your project

## Skills & Commands

| Trigger | What it does |
|---|---|
| `/prd` | Guided PRD creation (problem → personas → success criteria → acceptance criteria) |
| `adr` skill | Structured Architecture Decision Records |

## Automatic Behaviors (SessionStart Hook)

Every time Claude opens in a git repo:

1. **`.ai/` auto-init** — If the repo doesn't have a `.ai/` directory, it's created with scaffold files and Claude silently populates them from the codebase before your first message.
2. **Tasks sync** — A 20-minute recurring job is scheduled automatically. Every 20 minutes Claude silently updates `.ai/tasks.md` with what's been done, what's in progress, and what's next.

Nothing to set up. Just open Claude in any repo.

## Repo Memory Convention

Every project gets a `.ai/` directory (created automatically on first use):

```
.ai/
  project.md       # overview — auto-populated from codebase
  architecture.md  # design / modules — auto-populated from codebase
  commands.md      # how to run — auto-populated from codebase
  tasks.md         # current priorities — updated every 20 min automatically
  decisions.md     # decision log (ADRs) — maintained by adr skill
```

Claude reads these at session start to maintain context across sessions.

## Customization

1. **Stack Defaults** — Edit the `## Stack Defaults` section in `CLAUDE.md`
2. **Permissions** — Add team-specific `allow`/`deny` rules to `settings.json`
3. **Skills** — Add new skills to `skills/` or `plugins/local/user-skills/skills/`
4. **MCP Servers** — Add your org's MCP connections to `CLAUDE.md` and `settings.json`
