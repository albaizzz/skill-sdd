---
name: sdd
description: Routes SDD work through foundation-gate, sdd-specify, and sdd-task. Use when a request spans multiple SDD phases.
---

# SDD Workflow Router

1. Use `foundation-gate` when project context documents are missing or stale.
2. Use `sdd-specify` for human-authored 13-point specifications. AI validates read-only and may add only a separate `AI Agent Advisor` appendix when asked.
3. After human approval of the spec, the human authors the task plan. Use `sdd-task` to validate it without editing.
4. Execute tasks only after human approval of the plan and an explicit request to implement.

Never write or modify the human-authored specification or task plan. Never self-approve.
