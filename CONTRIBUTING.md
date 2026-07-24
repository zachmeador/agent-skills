# Contributing

This repository is a catalog of installable agent skills. Favor portability, clarity, and a
small review surface over host-specific features.

## Add a skill

1. Create `skills/<skill-name>/SKILL.md`.
2. Add only the resource directories the skill actually needs.
3. Test the instructions on a realistic task and run every added script.
4. Add the skill to the alphabetized catalog in `README.md`.
5. Run the validation checks below.

Use this structure:

```text
skills/<skill-name>/
├── SKILL.md
├── scripts/       # Optional executable helpers
├── references/    # Optional material the agent reads when needed
├── assets/        # Optional files copied or adapted into output
└── agents/        # Optional host UI metadata; never required for core behavior
```

Do not put a `README.md`, changelog, installation guide, or contributor documentation inside
a skill. The installed directory should contain only files that help an agent perform the
skill. Repository-level documentation belongs at the repository root.

## Naming and metadata

- Name skill directories with lowercase ASCII letters, digits, and single hyphens.
- Keep names between 1 and 64 characters. Do not start or end with a hyphen.
- Make the frontmatter `name` exactly match the parent directory.
- Always include a non-empty `description` of at most 1024 characters.
- Make the description say both what the skill does and when to activate it. Include terms a
  user is likely to put in a request.
- Use only `name` and `description` unless an optional field from the open specification is
  necessary. If a skill requires a particular host, executable, package, operating system, or
  network access, declare that briefly with `compatibility`.
- Treat `allowed-tools` as experimental and host-dependent. Omit it by default. Never use it
  to broadly pre-authorize shell execution merely for convenience.
- Do not add a per-skill version field without a repository-wide process that consumes it.
  Git tags and commit SHAs are the source of truth for published versions.

Minimal frontmatter:

```yaml
---
name: skill-name
description: >-
  Perform a specific workflow. Use when the user asks for the relevant task or
  mentions its key inputs.
---
```

## Write effective instructions

- Write for a capable agent. Include non-obvious procedure, constraints, decision rules, and
  verification; omit generic explanations.
- Use direct, imperative language.
- Keep `SKILL.md` under 500 lines and, as a practical target, under 5,000 tokens.
- Put activation cues in the frontmatter description because clients inspect it before
  loading the body.
- Keep essential workflow in `SKILL.md`. Move detailed specifications, schemas, and
  variant-specific guidance to focused files in `references/`.
- Link every optional resource from `SKILL.md` and say when to read or run it.
- Reference files relative to the skill root, for example
  `references/api.md` or `scripts/validate.py`.
- Keep references one hop from `SKILL.md`; avoid chains in which one reference is needed to
  discover another.
- Include completion checks and important failure behavior. Do not prescribe one
  implementation when several safe approaches are equally valid.
- Do not repeat the same guidance across `SKILL.md` and a reference file.

## Scripts and assets

- Add a script only for repeatable work that benefits from deterministic execution.
- Prefer standard-library implementations when that keeps the script clear.
- Document required runtimes, packages, environment variables, network access, and expected
  arguments in `SKILL.md` or `compatibility`.
- Resolve bundled files relative to the skill directory rather than assuming the caller's
  current working directory.
- Validate inputs, produce useful errors, and use non-zero exit codes on failure.
- Do not commit secrets, credentials, local paths, caches, build output, or dependency
  directories.
- Avoid opaque binaries. When an asset must be binary, document its source, purpose, and
  license in `SKILL.md`.
- Preserve third-party notices and confirm that bundled material can be redistributed.

## Portability

- Target the open Agent Skills format before any single host extension.
- Do not add duplicate copies under `.claude/skills/`, `.agents/skills/`,
  `.github/skills/`, or another host directory.
- Keep optional metadata under `agents/` supplemental. A client that ignores it must still be
  able to use the complete skill.
- Do not assume a particular tool name or permission model when a generic instruction works.
- Isolate unavoidable host-specific behavior, declare it in `compatibility`, and explain the
  fallback or failure mode.
- Do not assume that a skill is installed from the repository root or that sibling skills
  are present.

## Safety review

Treat a skill as executable supply-chain content even when it contains only Markdown.

- Read the full diff, including scripts and referenced files.
- Reject instructions that obtain credentials unnecessarily, weaken security controls,
  conceal actions, or transmit user data without an explicit task requirement.
- Minimize network access and third-party dependencies.
- Require explicit user confirmation in the skill before destructive, irreversible,
  privileged, or externally visible actions.
- Never tell an agent to bypass its host's permission or sandbox controls.
- Verify download URLs and pin dependencies when reproducibility or integrity matters.

## Validate

For each changed skill:

```sh
# Validate against the reference implementation: https://github.com/agentskills/agentskills
skills-ref validate skills/<skill-name>

# Confirm that a common downloader discovers the catalog.
npx skills add . --list
```

If GitHub CLI 2.90.0 or newer with preview agent-skill support is available, also validate
repository publication settings:

```sh
gh skill publish --dry-run
```

In addition:

- Run every new or changed script with a normal case and a representative failure case.
- Follow the skill on at least one realistic task and verify the result, not merely that the
  instructions were read.
- Confirm all relative links and paths resolve from the skill root.
- Confirm `README.md` lists additions, removals, and renames.

If a listed validation tool is unavailable, record what was checked manually in the pull
request instead of claiming the check passed.

## Change and release policy

- Keep each change focused on one skill or one repository-wide convention.
- Treat a renamed skill as a removal plus an addition; mention migration impact clearly.
- Call out changes that alter triggers, required tools, permissions, network behavior, output
  formats, or destructive behavior.
- Review dependency and external-API assumptions whenever a skill changes.
- Remove stale references and unused resources in the same change that makes them obsolete.
- Use repository-wide semantic Git tags when releases begin. Consumers that need stronger
  reproducibility should pin a commit SHA.
- Do not promise backward compatibility for unreleased skills. After a tagged release,
  describe breaking behavior in the release notes.
- Do not publish the repository or accept third-party contributions until a root `LICENSE`
  states the terms. Declare and bundle any different per-skill terms.

## Review checklist

- [ ] The directory is `skills/<name>/` and `name` matches it.
- [ ] The description clearly states what the skill does and when it activates.
- [ ] `SKILL.md` is concise and all referenced resources exist.
- [ ] Dependencies and compatibility constraints are explicit.
- [ ] Scripts were exercised on success and failure paths.
- [ ] Security, privacy, destructive actions, and licenses were reviewed.
- [ ] The skill works without repository-relative or host-specific assumptions.
- [ ] Validation passes, or unavailable checks are documented.
- [ ] The root skill catalog is current.
