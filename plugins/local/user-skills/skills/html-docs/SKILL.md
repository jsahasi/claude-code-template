---
name: html-docs
description: Generate professional, responsive, themed HTML documentation with auto-discovery. Use when creating test plans, security reviews, architecture docs, scalability assessments, or any standalone HTML documentation.
---

# HTML Documentation Generator

**Announce:** "Using html-docs skill to generate documentation."

## Parameters

| Param | Default | Description |
|-------|---------|-------------|
| `outputDir` | `./docs/` | Where HTML files are written |
| `foregroundColor` | `#4f46e5` | Primary accent color (maps to `--primary` and `--accent`) |
| `backgroundColor` | `#f8f9fc` | Page background (maps to `--bg`) |
| `fontColor` | `#1a1d2e` | Body text color (maps to `--text`) |
| `badgeColor` | `var(--accent)` | Hero badge background color |

Parse parameters from the user's prompt. If not specified, use defaults.

## Process

1. **Determine doc type** from user request: test-plan, security-review, scalability, architecture, recent-changes, or generic
2. **Run auto-discovery** commands for that doc type (see below)
3. **Generate HTML** using the template below, populated with discovered data
4. **Write file** to `outputDir`
5. **Optionally generate doc-nav.js** if multiple docs exist in outputDir

## HTML Template

Every generated doc MUST use this exact structure. The CSS is self-contained — no external dependencies.

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>{{PAGE_TITLE}}</title>
<style>
  :root {
    --bg: {{backgroundColor}}; --card: #ffffff; --border: #e2e6ef; --text: {{fontColor}}; --text2: #5a6070;
    --primary: {{foregroundColor}}; --accent: {{foregroundColor}}; --green: #059669; --amber: #d97706; --red: #dc2626;
    --heading: #111827; --hero-bg: linear-gradient(135deg, #eef0f8 0%, #e8eaf6 100%);
  }
  html.dark-mode {
    --bg: #0f1117; --card: #1a1d27; --border: #2a2d3a; --text: #c9cfe0; --text2: #7c8499;
    --primary: #a5b4fc; --accent: #6366f1; --green: #34d399; --amber: #fbbf24; --red: #f87171;
    --heading: #ffffff; --hero-bg: linear-gradient(135deg, #1a1d27 0%, #1e2035 100%);
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { background: var(--bg); color: var(--text); font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; font-size: 14px; line-height: 1.7; padding: 0 0 4rem; }
  .hero { background: var(--hero-bg); border-bottom: 1px solid var(--border); padding: 3rem 3.5rem 2.5rem; }
  .badge { display: inline-block; background: {{badgeColor}}; color: #fff; font-size: 0.65rem; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase; padding: 0.25rem 0.6rem; border-radius: 4px; margin-bottom: 1rem; }
  h1 { font-size: 2rem; font-weight: 700; color: var(--heading); margin-bottom: 0.5rem; }
  .subtitle { color: var(--text2); font-size: 0.9rem; }
  .meta { margin-top: 1.5rem; display: flex; gap: 2rem; font-size: 0.8rem; color: var(--text2); flex-wrap: wrap; }
  .meta strong { color: var(--text); }
  .content { max-width: 920px; margin: 0 auto; padding: 2.5rem 3.5rem; }
  h2 { font-size: 1.15rem; font-weight: 700; color: var(--primary); margin: 2.5rem 0 0.875rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--border); }
  h3 { font-size: 0.95rem; font-weight: 600; color: var(--heading); margin: 1.5rem 0 0.5rem; }
  p { color: var(--text); margin-bottom: 0.75rem; }
  ul, ol { padding-left: 1.5rem; margin-bottom: 0.75rem; }
  li { color: var(--text); margin-bottom: 0.35rem; }
  .card { background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 1.25rem 1.5rem; margin-bottom: 1rem; }
  table { width: 100%; border-collapse: collapse; margin-bottom: 1rem; font-size: 0.82rem; }
  th { background: rgba(99,102,241,0.1); color: var(--primary); font-weight: 600; text-align: left; padding: 0.6rem 0.75rem; border-bottom: 1px solid var(--border); }
  td { padding: 0.5rem 0.75rem; border-bottom: 1px solid var(--border); color: var(--text); vertical-align: top; }
  tr:last-child td { border-bottom: none; }
  .tag { display: inline-block; font-size: 0.7rem; font-weight: 600; padding: 0.15rem 0.5rem; border-radius: 4px; margin: 0.1rem; }
  .tag.green { background: rgba(52,211,153,0.12); color: var(--green); }
  .tag.red { background: rgba(248,113,113,0.12); color: var(--red); }
  .tag.amber { background: rgba(251,191,36,0.12); color: var(--amber); }
  .tag.blue { background: rgba(99,102,241,0.12); color: var(--primary); }
  code { font-size: 0.78rem; background: rgba(99,102,241,0.08); padding: 0.1rem 0.3rem; border-radius: 3px; }
  /* Dashboard grid */
  .dashboard { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
  .dash-card { background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 1rem 1.25rem; text-align: center; }
  .dash-card .number { font-size: 2rem; font-weight: 700; color: var(--heading); }
  .dash-card .label { font-size: 0.75rem; color: var(--text2); margin-top: 0.25rem; }
  /* Bar charts */
  .bar-container { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; }
  .bar-label { font-size: 0.78rem; width: 140px; text-align: right; color: var(--text2); flex-shrink: 0; }
  .bar-track { flex: 1; height: 22px; background: rgba(99,102,241,0.08); border-radius: 4px; overflow: hidden; position: relative; }
  .bar-fill { height: 100%; border-radius: 4px; display: flex; align-items: center; justify-content: flex-end; padding-right: 0.5rem; }
  .bar-fill span { font-size: 0.7rem; font-weight: 600; color: #fff; }
  .pass-fill { background: var(--green); }
  .fail-fill { background: var(--red); }
  /* Findings (security) */
  .finding { border-left: 3px solid var(--border); padding-left: 1rem; margin-bottom: 1.25rem; }
  .finding.critical { border-left-color: var(--red); }
  .finding.high { border-left-color: #f97316; }
  .finding.medium { border-left-color: var(--amber); }
  .finding.low { border-left-color: var(--green); }
  .finding.info { border-left-color: var(--primary); }
  .severity { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; }
  .severity.critical { color: var(--red); }
  .severity.high { color: #f97316; }
  .severity.medium { color: var(--amber); }
  .severity.low { color: var(--green); }
  .severity.info { color: var(--primary); }
  /* 2-column grid */
  .grid2 { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem; }
  /* Responsive */
  @media (max-width: 640px) {
    .hero { padding: 2rem 1.25rem 1.5rem; }
    .content { padding: 1.5rem 1.25rem; }
    .meta { flex-direction: column; gap: 0.5rem; }
    .dashboard { grid-template-columns: repeat(2, 1fr); }
    .grid2 { grid-template-columns: 1fr; }
    .bar-label { width: 80px; font-size: 0.7rem; }
    h1 { font-size: 1.5rem; }
  }
</style>
<script>
(function(){
  var theme = new URLSearchParams(window.location.search).get('theme');
  if (theme === 'dark') document.documentElement.classList.add('dark-mode');
})();
</script>
</head>
<body>
<div class="hero">
  <div class="badge">{{BADGE_TEXT}}</div>
  <h1>{{TITLE}}</h1>
  <p class="subtitle">{{SUBTITLE}}</p>
  <div class="meta">
    {{META_SPANS}}
  </div>
</div>
<div class="content">
  {{CONTENT_SECTIONS}}
</div>
<script src="doc-nav.js"></script>
</body>
</html>
```

### Template Variables

| Variable | Description |
|----------|-------------|
| `{{PAGE_TITLE}}` | `<title>` tag content |
| `{{BADGE_TEXT}}` | Hero badge label (e.g., "QA — Test Plan") |
| `{{TITLE}}` | Main heading |
| `{{SUBTITLE}}` | One-line description under title |
| `{{META_SPANS}}` | `<span><strong>Label:</strong> Value</span>` entries |
| `{{CONTENT_SECTIONS}}` | All h2/h3 sections, cards, tables, dashboards |

### Color Customization

When user provides custom colors, replace ONLY the `:root` light-mode values. Dark mode values are fixed for readability. Example:
- `foregroundColor: #0ea5e9` → replace `--primary` and `--accent` in `:root`
- `backgroundColor: #fefce8` → replace `--bg` in `:root`
- `fontColor: #292524` → replace `--text` in `:root`
- `badgeColor: #dc2626` → replace `.badge { background: ... }`

## Auto-Discovery by Doc Type

### test-plan

Run these commands and parse output:
1. `pytest --collect-only -q 2>/dev/null | tail -1` → total test count
2. `pytest tests/ -q --tb=no 2>&1` → pass/fail counts, duration
3. `pytest tests/ -v --tb=short 2>&1` → per-test results for table
4. `find tests/ -name "test_*.py" | wc -l` → test file count
5. `pytest --cov=app --cov-report=term-missing -q 2>&1` → coverage (if pytest-cov installed)

**Generate:**
- Dashboard: total tests, passed, failed, test files, duration, coverage %
- Bar chart: pass rate per test file (`.bar-container` + `.bar-fill`)
- Table: per-file breakdown with test names, status tags
- Section: previously failing tests (if any)

### security-review

Search codebase for security patterns:
1. `grep -rn "CORS\|cors" --include="*.py" --include="*.ts"` → CORS config
2. `grep -rn "auth\|Auth\|bearer\|Bearer\|api_key\|API_KEY" --include="*.py"` → auth patterns
3. `grep -rn "sanitiz\|DOMPurify\|escape\|XSS" --include="*.py" --include="*.ts" --include="*.tsx"` → input validation
4. `grep -rn "rate.limit\|slowapi\|throttl" --include="*.py"` → rate limiting
5. `grep -rn "CSP\|Content-Security-Policy\|X-Frame\|X-Content-Type" --include="*.py"` → security headers
6. `grep -rn "parameteriz\|sql.*inject\|\$[0-9]\|%s.*query" --include="*.py"` → SQL injection
7. `grep -rn "\.env\|secret\|password\|credential" --include="*.py" --include="*.yaml" --include="*.yml"` → secrets

**Generate:**
- Dashboard: count by severity (Critical / High / Medium / Low / Info)
- Controls table: control name, implementation, status tag
- Findings: `.finding` blocks with severity border colors
- OWASP matrix: mapping findings to OWASP Top 10 categories

### scalability

Read infrastructure files:
1. `cat docker-compose.yml 2>/dev/null || cat docker-compose.yaml 2>/dev/null` → services, replicas, resources
2. `cat Dockerfile* 2>/dev/null` → build stages, base images
3. `grep -rn "pool\|worker\|connection\|replica\|cache\|redis" --include="*.py" --include="*.yaml"` → scaling patterns
4. `grep -rn "gunicorn\|uvicorn\|workers" --include="*.py" --include="*.cfg" --include="*.toml"` → server config

**Generate:**
- Architecture table: service, technology, scaling mechanism, current config
- Resource allocation cards
- Bottleneck analysis
- Recommendations table

### architecture

Read project metadata:
1. `cat package.json 2>/dev/null` → frontend deps, scripts
2. `cat pyproject.toml 2>/dev/null || cat setup.py 2>/dev/null` → backend deps
3. `cat docker-compose.yml 2>/dev/null` → service topology
4. `find . -name "*.py" -path "*/app/*" | head -30` → backend structure
5. `find . -name "*.tsx" -o -name "*.ts" | grep -v node_modules | head -30` → frontend structure

**Generate:**
- Stack overview table: layer, technology, version
- Service topology table
- Directory structure
- Key integration points

### recent-changes

Read git history:
1. `git log --oneline -20` → recent commits
2. `git log --since="7 days ago" --pretty=format:"%h %s (%an, %ar)"` → last week
3. `git diff --stat HEAD~10` → files changed

**Generate:**
- Timeline of changes grouped by feature/area
- Impact summary

### generic

No auto-discovery. Generate a skeleton with:
- Hero (badge, title, subtitle, meta)
- Executive Summary section (empty card)
- 3 placeholder h2 sections with empty cards
- User fills in content

## Document Registration

External documents (created outside the skill) can be registered with the doc-nav widget. This allows parent applications or other tools to create their own HTML docs and wire them into the navigation dropdown.

### How It Works

When generating `doc-nav.js`, the skill supports two modes for each document entry:

1. **Managed** (default): Document was generated by the skill. Will be reformatted to the skill's template on regeneration.
2. **Registered**: Document was created externally. Linked as-is in the nav — never reformatted.

### Registration via doc-manifest.json

Create a `doc-manifest.json` file in the outputDir to declare all documents:

```json
{
  "docs": [
    { "label": "Test Plan", "path": "test-plan.html", "type": "managed" },
    { "label": "Security Review", "path": "security-review.html", "type": "managed" },
    { "label": "MRD", "path": "mrd.html", "type": "registered" },
    { "label": "PRD", "path": "prd.html", "type": "registered" },
    { "label": "Recent Changes", "path": "recent-changes.html", "type": "managed", "nav": false }
  ]
}
```

### Fields

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `label` | yes | — | Display name in the nav dropdown |
| `path` | yes | — | Filename (relative to outputDir) |
| `type` | no | `"managed"` | `"managed"` = skill owns it (regenerated to skill template). `"registered"` = external (linked as-is, never reformatted) |
| `nav` | no | `true` | `false` = excluded from nav dropdown. Document still exists and is accessible by URL, but not listed in the floating nav widget. Useful for embedded documents (e.g., recent-changes loaded via fetch) or internal-only docs. |

### Behavior

- **On regeneration** (`/html-docs regenerate`): managed docs are regenerated from auto-discovery. Registered docs are left untouched.
- **On doc-nav.js generation**: only entries with `"nav": true` (or no `nav` field) appear in the dropdown.
- **If no manifest exists**: the skill scans the outputDir for `.html` files and treats them all as managed with `nav: true`. A `doc-manifest.json` is auto-generated for future use.
- **Adding a new doc**: append an entry to `doc-manifest.json` with the appropriate type. On next regeneration, the nav updates automatically.

### Registration Command

Users can register an external document via prompt:

```
/html-docs register mrd.html as "MRD" (external, keep as-is)
/html-docs register recent-changes.html as "Recent Changes" (exclude from nav)
```

The skill will update `doc-manifest.json` accordingly.

## Doc-Nav Widget

When generating docs, also create `doc-nav.js` in the outputDir. This is a floating, draggable navigation widget.

```javascript
/**
 * Shared navigation dropdown for HTML docs.
 * Include via <script src="doc-nav.js"></script> at end of <body>.
 * Automatically detects current page and highlights it.
 */
(function () {
  // Auto-discover docs in same directory by scanning known patterns
  // Or use a hardcoded list — update this array when adding/removing docs
  var docs = [
    // { label: 'Document Name', path: 'filename.html' },
  ];

  // IMPORTANT: Populate the docs array above with all HTML files in the outputDir.
  // Each entry needs a human-readable label and the filename.

  var currentFile = window.location.pathname.split('/').pop();
  var theme = new URLSearchParams(window.location.search).get('theme');
  var themeParam = theme ? '?theme=' + theme : '';
  var isDark = document.documentElement.classList.contains('dark-mode');

  var nav = document.createElement('div');
  nav.style.cssText = 'position:fixed;top:12px;right:12px;z-index:9999;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;font-size:13px;cursor:move;';

  // Draggable
  var isDragging = false, dragX, dragY;
  nav.addEventListener('mousedown', function(e) {
    if (e.target.tagName === 'A') return;
    isDragging = true;
    dragX = e.clientX - nav.offsetLeft;
    dragY = e.clientY - nav.offsetTop;
  });
  document.addEventListener('mousemove', function(e) {
    if (!isDragging) return;
    nav.style.left = (e.clientX - dragX) + 'px';
    nav.style.top = (e.clientY - dragY) + 'px';
    nav.style.right = 'auto';
  });
  document.addEventListener('mouseup', function() { isDragging = false; });

  var btn = document.createElement('button');
  btn.textContent = 'Documents \u25BE';
  btn.style.cssText = 'padding:6px 14px;border-radius:6px;border:1px solid ' + (isDark ? '#3a4060' : '#d1d5db') + ';background:' + (isDark ? '#1a1d27' : '#fff') + ';color:' + (isDark ? '#c9cfe0' : '#374151') + ';cursor:pointer;font-size:13px;font-weight:600;box-shadow:0 1px 3px rgba(0,0,0,0.1);';

  var dropdown = document.createElement('div');
  dropdown.style.cssText = 'display:none;position:absolute;right:0;top:100%;margin-top:4px;min-width:200px;border-radius:8px;border:1px solid ' + (isDark ? '#3a4060' : '#e2e6ef') + ';background:' + (isDark ? '#1a1d27' : '#fff') + ';box-shadow:0 4px 12px rgba(0,0,0,0.15);padding:4px 0;';

  docs.forEach(function (doc) {
    var a = document.createElement('a');
    a.href = doc.path + themeParam;
    a.textContent = doc.label;
    var isCurrent = currentFile === doc.path;
    a.style.cssText = 'display:block;padding:7px 14px;text-decoration:none;color:' + (isDark ? '#c9cfe0' : '#374151') + ';font-size:13px;' + (isCurrent ? 'font-weight:700;background:' + (isDark ? 'rgba(99,102,241,0.15)' : 'rgba(99,102,241,0.08)') + ';color:' + (isDark ? '#a5b4fc' : '#4f46e5') + ';' : '');
    a.onmouseenter = function () { if (!isCurrent) a.style.background = isDark ? '#252d45' : '#f3f4f6'; };
    a.onmouseleave = function () { if (!isCurrent) a.style.background = 'transparent'; };
    dropdown.appendChild(a);
  });

  btn.onclick = function (e) {
    e.stopPropagation();
    dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
  };
  document.addEventListener('click', function () { dropdown.style.display = 'none'; });

  nav.appendChild(btn);
  nav.appendChild(dropdown);
  document.body.appendChild(nav);
})();
```

**When generating doc-nav.js**, read `doc-manifest.json` from the same directory. Only include entries where `nav` is `true` (or not set). If no manifest exists, scan the outputDir for all `.html` files and populate the `docs` array with `{ label, path }` entries. Derive labels from filenames: `test-plan.html` → `Test Plan`, `security-review.html` → `Security Review`. Then auto-generate `doc-manifest.json` for future use.

## Scheduling

### Claude Code Cron

Tell the user they can schedule regeneration:

```
Use CronCreate to schedule: /html-docs regenerate
Example: every 30 minutes, regenerate all docs in outputDir
```

### Shell Script (regenerate-docs.sh)

When the user asks for a CI/CD script, generate `regenerate-docs.sh` in the outputDir:

```bash
#!/usr/bin/env bash
# Auto-regenerate HTML documentation
# Usage: ./regenerate-docs.sh [output-dir]
# Add to crontab: */30 * * * * /path/to/regenerate-docs.sh /path/to/docs/

set -euo pipefail
OUTPUT_DIR="${1:-.}"
TIMESTAMP=$(date '+%B %d, %Y')

# --- Test Plan ---
if command -v pytest &>/dev/null; then
  echo "Collecting test results..."
  PYTEST_OUTPUT=$(pytest tests/ -q --tb=no 2>&1 || true)
  PASSED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= passed)' || echo "0")
  FAILED=$(echo "$PYTEST_OUTPUT" | grep -oP '\d+(?= failed)' || echo "0")
  TOTAL=$((PASSED + FAILED))
  # Generate test-plan.html with these values
  # (Template generation would go here — or call a Python script)
fi

# --- Security Review ---
echo "Scanning security patterns..."
AUTH_COUNT=$(grep -rn "auth\|Auth\|bearer\|api_key" --include="*.py" . 2>/dev/null | wc -l || echo "0")
CORS_COUNT=$(grep -rn "CORS\|cors" --include="*.py" . 2>/dev/null | wc -l || echo "0")
# (Template generation continues...)

echo "Docs regenerated in $OUTPUT_DIR at $TIMESTAMP"
```

**Note:** The shell script is a starting point. For full HTML generation without Claude, pair it with a Python template script or use `sed` replacements on a template file.

## Tag Semantics

Use tags consistently across all doc types:

| Tag | Class | When to use |
|-----|-------|-------------|
| Green | `.tag.green` | Passed, Active, Complete, Implemented, Low risk |
| Amber | `.tag.amber` | Warning, Partial, In Progress, Medium risk |
| Red | `.tag.red` | Failed, Critical, Blocked, High risk |
| Blue | `.tag.blue` | Info, Planned, Reference, Note |

## Rules

- Every HTML file is **fully self-contained** — inline CSS, no external stylesheets
- The only external reference is `doc-nav.js` (optional, at end of body)
- Never modify application source code — only write to outputDir
- Always run auto-discovery commands before generating content
- Use real data from commands, never placeholder/dummy data
- If a command fails (e.g., pytest not installed), skip that section gracefully
- Include `?theme=dark` support in every doc via the theme script
- Keep the CSS template identical across all docs for visual consistency
- Date in meta should be the actual generation date
