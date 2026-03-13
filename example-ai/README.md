# Example .ai/ Directory

Copy this folder to the root of any repo as `.ai/` and fill in the blanks.
The hook will auto-create blank scaffolds — but **pre-populated files are what
make Claude useful from session one**. The more context here, the less you
repeat yourself across sessions.

## Usage

```bash
cp -r /path/to/.claude_on24template/example-ai /your/repo/.ai
# Then edit each file for your repo
```

## File Guide

| File | What to put in it | Updated by |
|---|---|---|
| `project.md` | Purpose, users, key constraints | You (once) |
| `architecture.md` | Modules, data flow, key patterns | You (as it evolves) |
| `commands.md` | Exact run/test/deploy commands | You (keep current) |
| `tasks.md` | Current sprint + in-flight work | Auto (every 20 min) |
| `decisions.md` | Architecture decision log | ADR skill (append-only) |

**Tip:** Ask Claude to populate these from the codebase:
> "Read the codebase and fill in .ai/project.md, .ai/architecture.md, and .ai/commands.md"
