# GitHub Copilot Instructions

Read `AGENTS.md` and follow the SDD workflow:

1. Run `foundation-gate` before feature work.
2. The developer or product owner authors the 13-point spec. Use `sdd-specify` to ask questions and validate it read-only. AI may add only a separate `AI Agent Advisor` appendix when asked.
3. A human approves the spec.
4. A human authors the task plan. Use `sdd-task` to validate it without editing it.
5. A human approves the task plan before Copilot executes approved tasks.

Never write or modify the human-authored spec or task plan. Never self-approve or silently deviate from an approved plan. Verify every task against its Definition of Done.

Copilot skills are available from the `skills/` plugin directory or `.agents/skills/`. See `README.md` for installation and usage.
