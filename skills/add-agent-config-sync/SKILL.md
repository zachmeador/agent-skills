---
name: add-agent-config-sync
description: >-
  Add a small project-local shell script that copies one canonical skill tree
  into .agents/skills/ and .claude/skills/ and generates CLAUDE.md from
  AGENTS.md, then ignores those generated outputs. Use once when a repository
  needs generated agent configuration while keeping its source skills in any
  project-chosen directory.
---

# Add Agent Config Sync

Set up the repository once. The installed script handles later syncs; this skill is not an
ongoing workflow.

1. Find the project root, `AGENTS.md`, and the canonical directory containing the project's
   `SKILL.md` files. Keep that directory where the developer chose it; it might be `skills/`,
   `librarian/skills/`, `agents/dingdong/skills/`, or something else.
2. Copy [assets/sync-agent-config.sh](assets/sync-agent-config.sh) to
   `scripts/sync-agent-config.sh`.
3. Change the script's `skills_root` assignment to the canonical directory found in step 1.
   Keep it anchored to `project_root` when the directory is inside the repository.
4. If the script is installed somewhere other than a directory directly below the project
   root, adjust the `project_root` assignment.
5. Add `CLAUDE.md`, `.claude/`, and `.agents/` to the project root's `.gitignore`, preserving
   its existing entries.
6. Make the script executable. Wire it into the project's existing build command only when
   requested or when that is already the clear convention.
7. Run it once and confirm that `CLAUDE.md`, `.agents/skills/`, and `.claude/skills/` contain
   the expected copies.

The destination directories are disposable mirrors: the script removes and recreates them on
each run. Preserve project-owned skills in the canonical source directory, not in either
generated destination.
