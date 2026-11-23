# Architecture

> Project: `SDD SKILL`
> Type: `Static, multi-agent skills toolkit`
> Languages/Frameworks: `Markdown skills and templates, Bash installers, JSON plugin manifests; no fixed frontend framework`

## 1. System Overview

SDD SKILL is distributed as instructions and skills that run inside supported AI coding agents. It has no application backend or database of its own. Feature specifications and task plans are Markdown files stored in the user's target repository; any database schema or DDL discussed in a feature spec belongs to that target application.

```text
SDD SKILL GitHub repository
        │ installer / plugin
        ▼
Target repository + AI coding agent
        │
        ├── foundation-gate: reads project context and maintains foundation docs
        ├── sdd-specify: human authors the 13-point spec; AI validates and adds a separate
        │                "AI Agent Advisor" appendix; human approves
        ├── sdd-task: human authors task plan; AI validates it against the approved spec;
        │             human approves the plan
        └── AI executes approved tasks in the target repository and verifies their DoD

Optional for frontend work:
Target repository Figma design ── Figma MCP ── AI coding agent
```

## 2. Folder / Module Structure

```text
.
├── skills/
│   ├── foundation-gate/       # Project context gate
│   ├── sdd/                   # Workflow router
│   ├── sdd-specify/           # Human-authored 13-point spec validation
│   ├── sdd-task/              # Human-authored task-plan validation
│   └── spec-writer/           # Legacy alias for sdd-specify
├── .agents/skills/            # Codex and GitHub Copilot skill path
├── .claude/skills/            # Claude Code skills
├── .opencode/skills/          # OpenCode skills
├── .claude-plugin/            # Claude plugin and marketplace manifests
├── .github/                   # GitHub Copilot instructions
├── install.sh                # Downloads a GitHub archive and invokes the installer
├── install-foundation.sh     # Copies skills and entry-point instructions to a target repo
├── specs.md                  # SDD workflow reference
├── PRD.md
├── DESIGN_SYSTEM.md
└── ARCHITECTURE.md
```

`sdd-task` is packaged at `skills/sdd-task/SKILL.md` with its task-plan template under `skills/sdd-task/templates/`.

## 3. Request Lifecycle (Data Flow)

1. A developer installs the skills into a target repository or loads the plugin in a supported AI agent.
2. `foundation-gate` checks and creates project context documents before feature work.
3. A developer or product owner authors the feature specification through `sdd-specify`. AI validates completeness and puts any recommendations in a separate, clearly labeled `AI Agent Advisor` appendix; it does not edit the human-authored 13 points.
4. A human approver approves the specification.
5. A human authors the task plan. `sdd-task` validates that plan against the approved specification.
6. A human approves the task plan. The AI executes approved tasks in dependency order and verifies each task against its Definition of Done.
7. For frontend work, the agent may read the target project's Figma design through Figma MCP.

## 4. Components & Communication

| Component | Responsibility | Communication | Consumers |
|---|---|---|---|
| Skills and templates | Guide the SDD phases and define document structure | Markdown instructions consumed by the agent runtime | Developers, product owners, AI agents |
| Platform entry points | Load or reference the correct skill for each agent | Local Markdown configuration | Supported AI coding agents |
| Installers | Download and copy skills and instructions into a target repository | Shell commands; GitHub archive over HTTPS | Project maintainers |
| Figma MCP | Expose target-project design references for frontend work | MCP connection provided by the user's environment | AI coding agent |
| Target repository | Stores foundation docs, human-authored specs, task plans, and implementation | Version-controlled files | Human contributors and AI agents |

`sdd-task` is distributed from `skills/sdd-task/` alongside the other canonical skills.

## 5. Data Layer

- SDD SKILL has no application database.
- Foundation documents, feature specifications, task plans, and implementation changes live in the target repository.
- Database changes for a target feature are described in that feature's 13-point specification, including DDL and migration considerations when applicable.
- The target project's own database type, schema conventions, and migration process must be discovered from its foundation documents and codebase; SDD SKILL imposes none.

## 6. External Dependencies

- GitHub hosts the source repository and downloadable installer archive.
- Supported AI agent runtimes load the skills and execute approved tasks.
- Figma MCP is optional and is used when the target frontend project has Figma designs.
- No SDD SKILL backend, database, queue, cache, or third-party application API is required.

## 7. Observability

- Workflow state is represented in the spec and task documents and their lifecycle statuses.
- Process metrics may be tracked per ticket: time to spec, review rounds, rework rate, and defects attributable to specification gaps.
- Metrics are not automatically collected by a service; automated collection is `assumed — verify`.

## 8. Deployment

- Skills are distributed from the GitHub repository through platform plugin mechanisms and shell installers.
- The installer downloads the selected GitHub ref and copies skills and entry-point instructions into a target repository.
- There is no SDD SKILL service to deploy. Feature implementations are deployed by the target project's own release process.

## 9. Key Decisions

- Human authorship is preserved for the 13-point specification and task plan.
- AI recommendations stay in a separate `AI Agent Advisor` appendix; the AI does not edit the user's specification sections.
- Human approval is required for the specification and task plan before implementation.
- SDD SKILL stays framework- and database-agnostic; target-project architecture governs implementation details.
