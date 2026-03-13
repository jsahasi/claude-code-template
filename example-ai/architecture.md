# Architecture

## System Overview

[1 paragraph: what are the main layers and how do they relate?]

Example:
> Next.js frontend with Zustand state, talking to Next.js API routes backed
> by Prisma/PostgreSQL. An LLM agent (Claude) receives chat messages and
> dispatches 20+ tools that mutate an EDL (Edit Decision List) representing
> the video project. Remotion renders the EDL to MP4 server-side.

## Key Modules

| Module | Path | Responsibility |
|---|---|---|
| [Module name] | `src/lib/[name]/` | [One sentence] |
| [Module name] | `src/lib/[name]/` | [One sentence] |

## Data Flow

```
[User action]
  → [Entry point]
  → [Processing layer]
  → [Storage / side effect]
  → [Response]
```

Example:
```
User sends chat message
  → POST /api/agent/chat
  → Agent picks tool (e.g. clip_video)
  → Tool mutates EDL in PostgreSQL
  → SSE stream returns updated project state to UI
```

## Key Patterns

- **[Pattern name]** — [Why it exists, where to find it]
- **[Pattern name]** — [Why it exists, where to find it]

Example:
- **Pluggable adapters** — LLM, transcription, storage all behind interfaces so
  dev/prod can swap implementations (`src/lib/adapters/`)
- **EDL as source of truth** — UI never stores video state locally; everything
  derives from the serialized EDL in the DB

## What to Read First (New Engineer)

1. `README.md` — setup
2. `prisma/schema.prisma` — data model
3. `src/lib/agent/system-prompt.ts` — LLM instructions
4. `src/lib/[core-module]/` — main business logic
