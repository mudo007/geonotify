# AI-assisted development decisions

This file is the most important file in this directory.
It documents where AI was used as a tool and where human engineering
judgment made the call. It is updated at the end of every session.

## How to read this file

- **Human decision** — the call that was made, and who made it
- **AI role** — what the AI contributed (options, tradeoffs, code, research)
- **Rationale** — why this decision, in the engineer's own words

This log exists because AI tools are good at generating options.
They are not good at understanding tradeoffs in context.
That gap is where engineering experience lives.

---

## Decision log

### Session 1 — KRaft over Zookeeper
**Human decision:** Use Kafka 3.9.0 in KRaft mode, no Zookeeper container.
**AI role:** Provided docker compose config options and explained KRaft maturity.
**Rationale:** KRaft is production-ready since Kafka 3.3. Removing Zookeeper
reduces stack complexity by one stateful service. Maps to what modern
teams actually run. Simpler is better for a demo — fewer failure points.

### Session 1 — Self-hosted Kafka over managed cloud service
**Human decision:** Self-hosted via Strimzi on GKE, not Confluent or GCP managed Kafka.
**AI role:** Provided cost breakdown showing managed Kafka at ~$1,200/month baseline.
**Rationale:** Cloud-agnostic portability is the right architectural property for
this project. The Kafka broker address is an env var — swapping it takes minutes.
Cost for a demo workload (including a 5-min load test) is negligible on self-hosted.

### Session 1 — Docker-only dev environment
**Human decision:** Nothing installed on the MacBook except Docker.
**AI role:** Provided Dockerfile.dev, air config, and Makefile structure.
**Rationale:** Reproducible environments are a team property, not a personal one.
If it only works on my machine, it doesn't work. This also makes the IaC story
cleaner — the dev environment is itself infrastructure-as-code.

### Session 1 — AGENTS.md as canonical AI context file
**Human decision:** Single AGENTS.md, symlinked to CLAUDE.md and GEMINI.md.
**AI role:** Explained current ecosystem conventions and Linux Foundation standardization.
**Rationale:** One source of truth beats N slightly-different files drifting apart.
Symlinks cost nothing. When the standard settles further, we update one file.

---

_Add a new entry at the end of each session._