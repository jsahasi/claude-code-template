---
name: adr
description: Generate Architecture Decision Records. Use when making significant technical decisions about frameworks, data models, APIs, infrastructure, or patterns.
---

# Architecture Decision Record (ADR) Skill

**Announce:** "Using the ADR skill to document this decision."

## When to Use
- Choosing between frameworks, libraries, or tools
- Designing data models or API contracts
- Infrastructure or deployment decisions
- Any decision that will be hard to reverse

## Process
1. Read context — understand the problem and existing constraints
2. Enumerate options — at least 2-3 realistic alternatives
3. Evaluate tradeoffs — performance, maintainability, complexity, reversibility
4. Recommend — clear recommendation with reasoning
5. Confirm — get user approval before writing
6. Append to .ai/decisions.md

## Output Format

## YYYY-MM-DD — [Decision Title]

**Status:** Accepted

**Context:**
[1-3 sentences: what problem, what constraints]

**Decision:**
[1-2 sentences: exactly what was decided]

**Options Considered:**
- Option A: [brief + key tradeoff]
- Option B: [brief + key tradeoff]
- Option C (chosen): [brief + why chosen]

**Consequences:**
- ✅ [positive outcome]
- ⚠️ [tradeoff or risk to watch]

## Rules
- Under 20 lines per ADR
- Capture "why not" for rejected options — most valuable part
- Never edit history — add follow-up entries for reversals
- Date = actual current date from system context
