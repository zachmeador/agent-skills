---
name: add-agent-config-sync
description: >-
  Set up a project to use AGENTS.md and skills/ as canonical cross-agent
  sources, generate CLAUDE.md for Claude Code, and expose every recursively
  discovered skill by copying it into both .agents/skills/ and .claude/skills/.
  Use when configuring or normalizing a repository for Codex, Claude Code,
  Copilot, Cursor, or other agents without hand-maintaining duplicate
  instructions and skills.
---

# Add Agent Config Sync

Install the bundled sync script so one repository can serve agents with different discovery
conventions.

## Inspect existing state

1. Locate the project root and read its repository instructions.
2. Inspect `AGENTS.md`, `CLAUDE.md`, `skills/`, `.agents/skills/`, and
   `.claude/skills/` before changing anything.
3. Treat existing instructions and skills as user content. Do not overwrite or discard them.
4. If only `CLAUDE.md` exists, move its durable project instructions into `AGENTS.md` before
   generating a replacement. Exclude any old generated-file notice.
5. If host-specific skill directories contain unique skills, move each complete skill
   directory into canonical `skills/`. Resolve duplicate names by comparing content and
   asking the user when the intended version is ambiguous.

## Install the script

1. Ensure the project has a canonical `AGENTS.md` and `skills/` directory.
2. Copy [assets/sync-agent-config.sh](assets/sync-agent-config.sh) to
   `scripts/sync-agent-config.sh` in the target project.
3. If that destination already exists, compare it with the bundled asset. Preserve deliberate
   project-specific behavior and explain any merge instead of replacing it blindly.
4. Keep the script executable when the platform tracks executable bits.
5. If the project has an established task runner, expose a clearly named
   `sync-agent-config` command. Do not attach the sync to install, build, commit, or deployment
   hooks unless the user asks.

Run from the project root:

```sh
./scripts/sync-agent-config.sh
```

The script:

- Generates `CLAUDE.md` with a short generated-file notice followed by the exact
  `AGENTS.md` content.
- Recursively discovers every `skills/**/SKILL.md`.
- Validates that each skill's frontmatter name matches its directory name and rejects
  duplicate names.
- Copies each complete skill directory to `.agents/skills/<name>` and
  `.claude/skills/<name>`; deployed skills contain no symlinks.
- Marks each generated destination directory with `.generated-by-sync-agent-config`.
- Replaces the complete generated destination on each run. Refuses to clear an existing
  non-empty destination unless it has the generated marker or the legacy manifest from an
  earlier version of this skill.
- Refuses to replace a hand-maintained `CLAUDE.md` or any unmarked, non-empty destination.

Use `--root PATH` only when the script is stored somewhere other than the target project's
`scripts/` directory. The script supports the Bash 3.2 version included with macOS.

## Verify

Run:

```sh
./scripts/sync-agent-config.sh --check
```

Confirm that:

- The command exits successfully.
- `CLAUDE.md` contains only the generated notice and current `AGENTS.md`.
- Every canonical skill appears as a complete directory copy in both host directories.
- Existing unmarked destination directories are refused rather than modified.
- The repository status contains only the intended script, generated instructions, skill
  copies, marker files, and any explicit task-runner integration.
