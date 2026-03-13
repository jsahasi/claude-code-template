# Commands

## Install

```bash
pnpm install          # or: npm install / pip install -r requirements.txt
cp .env.example .env  # then fill in secrets
```

## Run (Dev)

```bash
pnpm dev              # starts dev server at http://localhost:3000
```

Dependencies needed locally:
- [e.g. PostgreSQL: `docker-compose up -d db`]
- [e.g. Redis: `docker-compose up -d redis`]

## Test

```bash
pnpm test             # run all tests
pnpm test:watch       # watch mode
pnpm test src/lib/agent  # run specific folder
```

Expected: [X] tests, ~[Y]s runtime. Known failures: [list any known flaky tests]

## Build

```bash
pnpm build            # production build
pnpm start            # run production build locally
```

## Database

```bash
pnpm db:migrate       # run pending migrations (prod)
pnpm db:migrate:dev   # run + generate client (dev)
pnpm db:studio        # open Prisma Studio at localhost:5555
pnpm db:seed          # seed dev data
```

## Docker

```bash
docker-compose up              # full stack (app + db)
docker-compose up --build      # rebuild image first
docker build -f ci/Dockerfile . # production image
```

## Deploy

```bash
# GitLab CI deploys automatically on push to:
# - dev branch → dev environment
# - master branch → QA → prod (manual gate)

# To trigger manually:
git push gitlab master
```

## Useful One-Liners

```bash
# [Description]
[command]

# [Description]
[command]
```
