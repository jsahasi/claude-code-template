# html-docs — Self-Updating HTML Documentation Generator

Your project's docs are either outdated or nonexistent. You know it. Your team knows it. Nobody updates them because it's tedious, manual work that feels pointless when the code changes faster than the docs.

**html-docs fixes this.** It generates professional, responsive HTML documentation by reading your actual project state — test results, security patterns, infrastructure config, dependency lists. The docs update themselves because they're generated from reality, not written by hand.

## What You Get

- **Test Plan & Results** — runs pytest, collects pass/fail counts, generates dashboards with bar charts and per-file breakdowns. Real numbers, not aspirational ones.
- **Security Review** — greps your codebase for auth, CORS, CSP, rate limiting, SQL parameterization. Maps findings to OWASP Top 10. Shows what's actually in place vs. what's missing.
- **Architecture Overview** — reads package.json, pyproject.toml, docker-compose.yml. Generates stack tables, service topology, directory structure. Always matches the current state.
- **Scalability Assessment** — parses Docker configs, worker counts, connection pools. Documents your actual resource allocation, not what you planned six months ago.
- **Any Custom Doc** — skeleton with the same professional template. You provide the content, it handles the design.

Every doc is a single standalone HTML file. No build step, no npm install, no framework. Open it in a browser. Ship it to stakeholders. Drop it in a wiki.

## The Design

- Dark mode via `?theme=dark` URL parameter
- Responsive down to 320px
- CSS variables for full color customization
- Dashboard grids, data tables, tag system (green/amber/red/blue), bar charts, severity-coded findings
- Floating draggable doc-nav widget for multi-doc suites
- Looks like a designer spent a week on it. Takes seconds to generate.

## Install

Copy the `html-docs` folder into your Claude Code skills directory:

```
~/.claude/plugins/local/user-skills/skills/html-docs/
```

## Usage

```
/html-docs Create a test plan for this project
/html-docs Generate a security review in ./reports/
/html-docs Create architecture docs with foregroundColor=#0ea5e9
/html-docs Regenerate all docs in frontend/public/docs/
```

### Example Prompts

**"Create a test plan doc in ./reports/"**
Runs pytest, collects all results, generates `reports/test-plan.html` with a full dashboard showing pass rates, coverage, and per-file breakdowns.

**"Generate a security review"**
Scans your codebase for auth patterns, CORS config, input validation, rate limiting, security headers. Produces a findings report with OWASP mapping and severity indicators.

**"Regenerate all docs"**
Re-runs auto-discovery for every doc type and rewrites all HTML files with fresh data.

## Scheduling

### Claude Code Cron (for developers)

```
Set up a cron to run /html-docs regenerate every 30 minutes
```

Your docs stay current without you thinking about it.

### CI/CD (for pipelines)

The skill can generate a `regenerate-docs.sh` shell script that runs the same discovery commands without Claude Code. Add it to your GitHub Actions, GitLab CI, or crontab.

## Document Registration

Already have docs? Wire them into the nav without reformatting:

```
/html-docs register mrd.html as "MRD" (external, keep as-is)
/html-docs register recent-changes.html as "Recent Changes" (exclude from nav)
```

External docs get linked in the navigation dropdown as-is. Managed docs get regenerated to the skill's template on every run. Control visibility with `"nav": false` in `doc-manifest.json` — the doc exists and is accessible by URL, but doesn't clutter the dropdown.

## Customization

| Parameter | Default | What it changes |
|-----------|---------|-----------------|
| `outputDir` | `./docs/` | Where files land |
| `foregroundColor` | `#4f46e5` | Accent color (headings, badges, links) |
| `backgroundColor` | `#f8f9fc` | Page background |
| `fontColor` | `#1a1d2e` | Body text |
| `badgeColor` | `var(--accent)` | Hero badge |

---

Built for developers who'd rather ship features than write docs. Your docs should be as automated as your tests.
