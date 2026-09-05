---
name: audit-agent-instructions
description: >-
  Audit a project's agent instruction files and skills for conflicting guidance,
  then write a concise Markdown report in the project root. Use when reviewing
  an agent-heavy repository for contradictory rules, overlapping skills, or
  unclear instruction precedence.
---

# Audit Agent Instructions

Assess the project without changing its instructions or skills.

1. Identify the project root and discover project-owned agent guidance. Check instruction
   files such as `AGENTS.md`, `CLAUDE.md`, repository tool rules, and every project-owned
   `SKILL.md`, including nested files. Follow references from those files when they contain
   additional instructions. Exclude dependencies, build output, caches, and user-global
   configuration outside the project.
2. Determine each instruction's scope and any documented precedence. Treat generated mirrors
   and identical copies as one source. Do not call two instructions contradictory merely
   because they overlap or use different wording: report a conflict only when both can apply
   to the same task and require incompatible behavior. Record plausible but ambiguous cases
   separately.
3. Write or replace `agent-instruction-audit.md` in the project root with:
   - a summary verdict and counts of confirmed and possible conflicts;
   - the files reviewed and any important exclusions;
   - one finding per conflict, citing both project-relative paths and the relevant lines or
     sections, explaining when the conflict occurs and suggesting the smallest resolution;
   - a short `No conflicts found` statement when there are no findings.

Keep the report concise and evidence-based. Do not repair conflicts unless the user separately
asks for changes.
