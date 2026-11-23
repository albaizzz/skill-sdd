# AGENTS.md — Repository Instructions (SDD)

Read this first. It governs every AI agent (opencode, Claude Code, Codex, GitHub Copilot) working in this repo.

## Specification-Driven Development (MANDATORY)

This project follows **SDD: no code touches the codebase until a technical specification is written, reviewed, and approved by a human.**

### Lifecycle
```
Foundation Gate → Human-Authored 13-Point Spec → AI Validation → Human Approval
→ Human-Authored Task Plan → AI Validation → Human Approval
→ AI Implementation → Verification → Done
```

1. **Foundation Gate** — `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, `AGENTS.md` must exist with substantive content (also checked in `docs/`). Missing → create them by interviewing the developer, one at a time, ≤3 rounds per file, mark unknowns `assumed — verify`.
2. **Specification authoring** — the developer or product owner writes `docs/specs/<ticket-id>.md` using the 13-point structure. AI may interview, validate completeness, and report gaps; it must not write or modify the human-authored 13 points.
3. **AI Agent Advisor** — AI may add a separate, clearly labeled appendix outside the 13 points. It must not rewrite or silently alter the human-authored specification.
4. **Review and approval** — AI reports gaps and risks; a human approves the spec. AI never self-approves.
5. **Task plan authoring** — a human writes `docs/tasks/<ticket-id>.md`, with ordered tasks, dependencies, target files, and per-task Definition of Done.
6. **Task validation and approval** — AI checks the human-authored task plan against the approved spec and reports mismatches. A human approves the plan before implementation.
7. **Implementation** — AI executes approved tasks one at a time in dependency order. No silent deviation.
8. **Verification** — run spec DoD + tests; report pass/fail per item. Never declare Done with failures.

The 13 specification points are:
   1 Business Requirement, 2 Goals, 3 Out of Scope, 4 Constraints, 5 Definition of Done, 6 Technical Solution, 6a Security & Compliance, 6b Decision Record, 7 Database Impact, 8 Code Impact (with `file:line`), 9 Testing & Regression, 10 Backward Compatibility & Rollback, 11 Deployment & Migration.

### Hard Rules
- The human authors the 13-point spec and task plan. AI validates and advises without changing either; the only AI-authored spec content permitted is a separate, clearly labeled `AI Agent Advisor` appendix outside the 13 points.
- Never implement without a human-approved spec and task plan. Never self-approve.
- Every codebase claim cites `file:line`. Unverified → `assumed — verify`. Never invent symbols or filenames.
- Spec lifecycle: `Draft → In Review → Approved → Task Breakdown → In Implementation → Deployed → Done`.

## Reference
- Foundation workflow: `skills/foundation-gate/SKILL.md`.
- Workflow router: `skills/sdd/SKILL.md`.
- Human-authored spec workflow: `skills/sdd-specify/SKILL.md`.
- Task workflow: `skills/sdd-task/SKILL.md`.
- Process detail + one-shot example: `specs.md`.
- Templates: `skills/foundation-gate/templates/`, `skills/sdd-specify/templates/`, and `skills/sdd-task/templates/`.

## Coding SOP
- Tech stack & versions: Markdown skills/templates, Bash installers, JSON manifests; no application framework or package manager.
- Project structure: `skills/<name>/` is the canonical plugin skill tree; `.agents/skills/`, `.claude/skills/`, and `.opencode/skills/` are native install targets.
- Code style: Follow the existing Markdown structure and skill frontmatter. Bash scripts use `set -euo pipefail` and quote variable expansions.
- Build/lint/typecheck: Not configured.
- Validation: `bash -n install.sh install-foundation.sh`; inspect Markdown and plugin manifests for structural consistency.
- Git workflow: Branch naming and commit format are `assumed — verify`; human review/approval is required before merging workflow changes.
- Do-not rules: No secrets in source; no feature implementation before both spec and task-plan approval; do not let AI edit human-authored spec or task-plan content.
