# Project

## What This Repo Does

[2-4 sentences. What problem does it solve? What is the output?]

Example:
> AI-powered video editor. Users upload webinar recordings; the system
> transcribes, chapters, and lets a chat agent clip/edit/render the video
> without a timeline UI. Output is a shareable MP4 or embedded player.

## Who Uses It

- **Primary:** [Role — how they interact with the system]
- **Secondary:** [Role — e.g. reviewers, admins]

## Entry Points

| Entry point | Purpose |
|---|---|
| `src/app/page.tsx` | Home / dashboard |
| `src/app/api/` | REST API routes |
| `src/lib/agent/` | LLM agent + tools |

## Key Constraints / Non-Obvious Things

- [e.g. "Video rendering is CPU-intensive — never run on the web dyno"]
- [e.g. "LocalFS storage mode exists for dev; prod always uses S3"]
- [e.g. "JWT access tokens expire in 15 min — refresh token is httpOnly cookie"]

## External Services

| Service | Purpose | Credential |
|---|---|---|
| Anthropic API | LLM agent | `ANTHROPIC_API_KEY` |
| [Service] | [Purpose] | `ENV_VAR_NAME` |
