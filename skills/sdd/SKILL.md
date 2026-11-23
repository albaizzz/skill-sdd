---
name: sdd
description: >
  Routes SDD work through foundation-gate, sdd-specify, and sdd-task.
  Use when a request spans multiple phases of the SDD workflow.
---

# SDD Workflow Router

Use the phase-specific skill; do not combine or bypass their ownership gates.

1. If project foundation documents are missing or stale, use `foundation-gate`.
2. For a feature specification, use `sdd-specify`. The human authors all 13 points; AI validates and may add only a separate `AI Agent Advisor` appendix when asked.
3. After the human approves the spec, the human authors a task plan. Use `sdd-task` to validate it without editing it.
4. Execute tasks only after the human approves the task plan and explicitly asks for implementation.

Never write or modify the human-authored specification or task plan. Never self-approve.
