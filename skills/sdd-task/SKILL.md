---
name: sdd-task
description: >
  Validates a human-authored task plan against its approved feature specification.
  The AI reports gaps but never writes or edits the plan. Use after a human approves
  the specification and before asking the AI to execute approved tasks.
---

# SKILL: sdd-task

## Core Purpose
Help humans create an implementation plan that faithfully follows an approved specification. The human authors `docs/tasks/<ticket-id>.md`; the AI checks consistency, reports gaps, and executes tasks only after human approval.

## Preconditions
1. The project foundation gate has passed.
2. The corresponding specification exists at `docs/specs/<ticket-id>.md`.
3. The specification has an explicit human-approved status. Never infer approval from a complete-looking draft.

If any prerequisite is missing, stop and report it. Do not write or modify the task plan.

## Human Authorship
- The human writes and edits every task, dependency, target file, and Definition of Done.
- If no task plan exists, point to `templates/TASKS.md`; do not create or populate a task plan.
- Do not rewrite, reorder, remove, or silently fix task-plan content.

## Read-Only Validation
Read the approved specification and human-authored task plan. For each task, check:
- It is in scope and traces to relevant specification requirements and points.
- Its target files and affected symbols are cited accurately; unverified references are `assumed — verify`.
- Its dependencies are valid, complete, and acyclic.
- Its Definition of Done is observable and pass/fail.
- Its verification covers the relevant acceptance criteria and regression risks.
- No task exceeds the specification's Non-Goals or introduces an unapproved design decision.

Return a validation table with `Pass`, `Fail`, or `Insufficient` per task, followed by specific gaps and questions for the human author. Do not edit the file to resolve findings.

## Approval and Execution
- The AI does not approve the task plan. Wait for explicit human approval.
- Execute tasks only when the human asks, and only from the approved plan.
- Work one task at a time in dependency order. Verify that task's DoD before proceeding.
- Do not change the task plan or silently deviate from the approved specification. If work requires a change, stop and ask the human to update and re-approve the plan/spec.
- Report changed files, verification results, and any blocked task.

## Reference
- Task-plan template: `templates/TASKS.md`
- Specification authoring and validation: `sdd-specify`
- Foundation gate: `foundation-gate`
