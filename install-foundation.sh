#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SRC_DIR/skills"
SPEC_FILE="$SRC_DIR/specs.md"
AGENTS_FILE="$SRC_DIR/AGENTS.md"
CLAUDE_FILE="$SRC_DIR/CLAUDE.md"
COPILOT_FILE="$SRC_DIR/.github/copilot-instructions.md"

usage() {
  echo "Usage: $0 <target-repo-path>"
  echo "Installs SDD skills into native project skill paths for OpenCode, Codex,"
  echo "GitHub Copilot, and Claude Code, plus their instruction entry points."
  echo
  echo "Example:"
  echo "  $0 /path/to/office/service-repo"
  exit 1
}

if [ $# -ne 1 ]; then usage; fi
TARGET="$1"

if [ ! -d "$TARGET" ]; then
  echo "ERROR: target '$TARGET' is not a directory" >&2
  exit 1
fi
if [ ! -d "$SKILLS_DIR" ]; then
  echo "ERROR: skills folder not found at '$SKILLS_DIR'" >&2
  exit 1
fi

install_or_append() {
  local src="$1" dst="$2" marker="$3"
  if [ ! -f "$src" ]; then
    echo "    SKIP ($marker): source missing '$src'"
    return 0
  fi
  if [ -f "$dst" ]; then
    if grep -q "$marker" "$dst" 2>/dev/null; then
      echo "    KEEP $dst (already contains SDD rules)"
    else
      cp "$src" "$dst"
      echo "    OVERWRITE $dst (had no SDD rules, replaced)"
    fi
  else
    cp "$src" "$dst"
    echo "    CREATE $dst"
  fi
}

install_skills() {
  local relative_dir="$1"
  local skill_src skill_name destination
  mkdir -p "$TARGET/$relative_dir"
  for skill_src in "$SKILLS_DIR"/*; do
    [ -d "$skill_src" ] || continue
    skill_name="${skill_src##*/}"
    destination="$TARGET/$relative_dir/$skill_name"
    mkdir -p "$destination"
    cp -R "$skill_src/." "$destination/"
    echo "    $skill_name -> $relative_dir/$skill_name/"
  done
}

echo "==> Installing SDD workflow into '$TARGET'"

# Native skill paths:
# .agents/skills is shared by Codex and GitHub Copilot.
# OpenCode and Claude Code also load their platform-specific directories.
install_skills ".agents/skills"
install_skills ".opencode/skills"
install_skills ".claude/skills"

# Shared instructions and platform entry points.
install_or_append "$SPEC_FILE" "$TARGET/specs.md" "Specification-Driven Development"

# AGENTS.md is read by Codex, GitHub Copilot, and OpenCode.
install_or_append "$AGENTS_FILE" "$TARGET/AGENTS.md" "Specification-Driven Development"

# Claude Code entry point.
install_or_append "$CLAUDE_FILE" "$TARGET/CLAUDE.md" "Claude Code"

# GitHub Copilot repository instructions.
mkdir -p "$TARGET/.github"
install_or_append "$COPILOT_FILE" "$TARGET/.github/copilot-instructions.md" "Copilot Instructions"

echo
echo "Done."
echo "- Skills: .agents/skills/, .opencode/skills/, .claude/skills/"
echo "- Docs:   specs.md, AGENTS.md, CLAUDE.md, .github/copilot-instructions.md"
echo
echo "Next:"
echo "1. Start or reload your agent so it discovers the installed skills."
echo "2. Run foundation-gate, then sdd-specify, then sdd-task."
echo "3. Review any existing AGENTS.md/CLAUDE.md kept by the installer for stale SDD instructions."
