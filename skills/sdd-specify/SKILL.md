---
name: sdd-specify
description: >
  Guides developers and product owners to author a complete 13-point feature specification.
  The AI asks questions and validates the human-authored spec but never writes or edits its 13 points.
  Use for specification authoring and review after foundation-gate passes.
---

# SKILL: sdd-specify

## Core Purpose
Help developers and product owners author precise, testable feature specifications. **The human owns and writes the 13-point spec.** The AI guides the author, checks completeness, reports gaps, and may add only a separate `AI Agent Advisor` appendix. This skill does not approve specs, author task plans, or implement code.

## Trigger Keywords
- PRD, DESIGN_SYSTEM, ARCHITECTURE, AGENTS, SDD, specification-driven development
- foundation docs, gathering requirements, new feature, draft spec, spec review, feature ticket, task breakdown, task planning

## The SDD Lifecycle
```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

## PHASE 0 — Foundation Gate

Run the `foundation-gate` skill first. Do not start Phase 1 until it reports PASS.

## PHASE 1 — Feature Requirements (Input Contract)
The developer supplies:
1. **Feature/Ticket Description** — what is being built and why.
2. **Affected Area (optional)** — module/service/endpoint names they suspect are involved.
3. **Priority** — P0/P1/P2 and any deadline.
4. **Existing Draft Spec (optional)** — a prior draft the agent should critique rather than start from scratch.

If the description is too vague to start, ask up to **3 targeted clarifying questions**. Report unresolved items as suggested `assumed — verify` markers; the human decides whether to add them to the spec.

## PHASE 2 — Draft the 13-Point Spec
Guide the human to create `docs/specs/<ticket-id>.md` using `templates/SPEC.md`. The human fills and edits all 13 points. The AI may show a blank scaffold if asked, but must not populate, paraphrase, rewrite, or otherwise modify the human-authored sections.

1. **Business Requirement** — context and why this feature is built.
2. **Goals** — success metrics / expected outcomes.
3. **Out of Scope (Non-Goals)** — strict boundaries to prevent scope creep.
4. **Constraints** — system, time, or resource limitations.
5. **Definition of Done** — checkable pass/fail criteria (not vague).
6. **Technical Solution** — architecture/flow sketch, API contracts (request/response shape, status codes), new dependencies.
6a. **Security & Compliance** — authz/authn impact, PII handling, secrets. If N/A, state explicitly *"N/A — no security impact."*
6b. **Decision Record** — alternatives considered & why rejected.
7. **Database Impact Changes** — schema changes, indexes, table locks, migration steps + idempotency + downtime window.
8. **Code Impact** — modules/services/endpoints modified, with `file:line` references. Include blast radius — every caller of modified functions.
9. **Testing & Regression Strategy** — how existing features stay unbroken; contract tests, smoke/manual regression checklist, sign-off owner.
10. **Backward Compatibility & Rollback Plan** — trigger criteria for rollback (error rate / p95 / SLA), who decides, partial-failure handling.
11. **Deployment & Migration Strategy** — feature toggles, release sequence, canary/ramp %, data seeding; **observability signals** validating a healthy deployment.

## PHASE 3 — Spec Review (Phase A: Devil's Advocate)
- Read the spec without editing it. Ask critical questions (Socratic method) so the human can close gaps. Example: *"You modified function X, called by Service Y. How do you handle backward compatibility for Y?"*
- **Focus on legacy risks:** N+1 queries, DB migration downtime, expanding blast radius, hidden callers.
- **Iteration cap:** max **3 Socratic rounds**. After that, stop asking and provide fillable hints/placeholders so the draft can progress.
- **Grade every point** `Pass / Fail / Insufficient`.
- Report the review in chat. The human updates the spec. The AI must not apply the gap report to the file.
- **Approved** only when: all 13 points **Pass**, no **Open Risk** flagged, AND the human approver confirms.
- **Rejected** specs return a gap report: point number, what is missing, the question the developer must answer.

## PHASE 4 — AI Agent Advisor Appendix
- Keep the 13-point spec human-authored and unchanged.
- Only when asked, append a separate `## AI Agent Advisor` section after the spec's existing content. Do not edit, reformat, or remove any preceding text.
- Label every item as an AI recommendation, include its rationale, and distinguish suggestions from accepted requirements.
- The human decides whether to incorporate a recommendation by editing the relevant 13-point section.

## PHASE 5 — Human Approval and Handoff
- Only a human can approve the specification. The AI never sets status to `Approved`.
- After approval, hand off task-plan authoring and validation to `sdd-task`.
- Implementation is handled only from a human-approved task plan.

## Spec Lifecycle & Traceability
- `Draft → In Review → Approved → Task Breakdown → In Implementation → Deployed → Done`
- Tracked in the spec file header under `docs/specs/<ticket-id>.md` (version-controlled).
- A complete feature delivers: spec.md, task list, implementation PR(s) linking ticket + spec, verification result.

## Process Metrics (to measure SDD effectiveness)
Track per ticket: **time to spec**, **socratic rounds used**, **rework rate** (PRs rejected for reasons the spec should have caught), **defect leak** (production incidents traceable to a spec gap).

## Codebase Awareness Rules
- Prefer **targeted reads** over full-codebase scans to protect context budget: start from entry-point/index files and the developer's module pointers, then follow the call graph outward.
- **Every claim about the codebase must cite `file:line`.** If a symbol cannot be verified, mark it `assumed — verify`; never invent module/function names.
- Flag unknown or deprecated areas rather than guessing.

## Rules
- **Never skip the gate.** Even if the developer says "just gather requirements", check the 4 files first.
- **Never create foundation docs without interviewing** — empty templates with placeholder text do NOT satisfy the gate.
- **Never proceed to feature requirements while the gate is blocked.**
- Never write or modify the human-authored 13 points.
- Never write or modify the human-authored task plan; hand off to `sdd-task`.
- Never approve a spec or task plan on behalf of a human.
- This skill does not implement code.
- If a file exists but is clearly stale/conflicting with the codebase, flag it to the developer; do not silently rewrite it.

## Multi-Agent Support
This skill works across agent tools. Each tool loads SDD instructions via its own mechanism, all pointing at the same workflow:

| Tool | Entry point | Skill location |
|------|-------------|----------------|
| OpenCode | `AGENTS.md` | `.opencode/skills/sdd-specify/SKILL.md` |
| Claude Code | `CLAUDE.md` | `.claude/skills/sdd-specify/SKILL.md` |
| Codex | `AGENTS.md` | `.agents/skills/sdd-specify/SKILL.md` |
| GitHub Copilot | `.github/copilot-instructions.md` + `AGENTS.md` | `.agents/skills/sdd-specify/SKILL.md` |

Ensure the generated `AGENTS.md` (foundation doc) always keeps its SDD rules section — that is what makes the gate machine-readable by any agent.
