# Agent Skills

A small collection of portable skills for AI agents.

This repository follows the open [Agent Skills specification](https://agentskills.io/specification).
Each skill is a self-contained directory whose entry point is `SKILL.md`. Compatible
installers can discover the skills in this repository and copy them to the location used by
Codex, Claude Code, GitHub Copilot, Cursor, and other agent hosts.

## Repository layout

```text
.
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md       # Required: metadata and instructions
│       ├── scripts/       # Optional: executable helpers
│       ├── references/    # Optional: documentation loaded on demand
│       ├── assets/        # Optional: templates and output resources
│       └── agents/        # Optional: host UI metadata
├── CONTRIBUTING.md
└── README.md
```

Keep the catalog flat: every immediate child of `skills/` is one installable skill. Do not
mirror the catalog into host-specific directories such as `.claude/skills/`,
`.agents/skills/`, or `.github/skills/`. Installers are responsible for putting a selected
skill in the correct host directory.

## Available skills

- [`add-agent-config-sync`](skills/add-agent-config-sync/) — Make `AGENTS.md` and `skills/`
  canonical, generate `CLAUDE.md`, and copy skills into both common host directories.

## Install

Skills are executable instructions. Inspect a skill and its scripts before installing it.

With the cross-agent [`skills` CLI](https://github.com/vercel-labs/skills), replace
`OWNER/REPO` with this repository's GitHub slug:

```sh
# List the skills in the repository.
npx skills add OWNER/REPO --list

# Install one skill interactively.
npx skills add OWNER/REPO --skill <skill-name>

# Install one skill globally for Codex.
npx skills add OWNER/REPO --skill <skill-name> --agent codex --global
```

With [GitHub CLI agent skills][github-skill-docs] (`gh` 2.90.0 or newer; currently a
public preview):

```sh
gh skill preview OWNER/REPO <skill-name>
gh skill install OWNER/REPO <skill-name>
```

To install manually, copy the complete skill directory—not only `SKILL.md`—into the skills
directory supported by your agent host.

## Create a skill

Create `skills/<skill-name>/SKILL.md` with the smallest portable frontmatter:

```md
---
name: skill-name
description: >-
  Describe what the skill does and the specific situations in which an agent
  should use it.
---

# Skill name

Write concise, imperative instructions for the agent.
```

The `name` must match the directory name. Use lowercase letters, digits, and single hyphens;
keep it at 64 characters or fewer. Put detailed material in `references/`, repeatable
deterministic operations in `scripts/`, and files intended for generated output in `assets/`.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the complete authoring, review, validation, and
maintenance conventions.

## Design goals

- Portable by default across agents that implement the open specification.
- Small entry points that use progressive disclosure.
- Auditable instructions and scripts with explicit dependencies.
- No secrets, generated clutter, or unexplained binary files.
- Changes that are easy to review and pin to a Git tag or commit SHA.

## License

Released under the [MIT License](LICENSE). If a skill uses different terms, bundle its license
in that skill directory and declare it with the optional frontmatter `license` field.

[github-skill-docs]: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills
