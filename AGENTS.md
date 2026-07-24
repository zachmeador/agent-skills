# Repository instructions

These instructions apply to the entire repository.

- Read `README.md` and `CONTRIBUTING.md` before adding or changing a skill.
- Store each installable skill at `skills/<skill-name>/SKILL.md`; keep the catalog flat.
- Do not create host-specific duplicate trees such as `.claude/skills/`,
  `.agents/skills/`, or `.github/skills/`.
- Make each frontmatter `name` match its directory and keep the `description` specific about
  both capability and activation conditions.
- Keep `SKILL.md` concise. Add `scripts/`, `references/`, or `assets/` only when used and
  link them directly from `SKILL.md`.
- Keep optional `agents/` UI metadata supplemental; the skill must work without it.
- Preserve portability. Declare unavoidable runtime, network, operating-system, or
  host-specific requirements.
- Inspect and run changed scripts. Review all skill content as executable supply-chain
  material.
- Update the alphabetized skill catalog in `README.md` whenever a skill is added, removed, or
  renamed.
- Run the validation commands in `CONTRIBUTING.md` when their tools are available. Report
  unavailable checks accurately.
- Do not add per-skill READMEs, changelogs, caches, generated output, dependencies, secrets,
  or unexplained binary files.
