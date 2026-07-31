#!/usr/bin/env bash

set -euo pipefail

project_root=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
skills_root="$project_root/skills"

{
  printf '<!-- Generated from AGENTS.md. Do not edit directly. -->\n\n'
  cat "$project_root/AGENTS.md"
} >"$project_root/CLAUDE.md"

for destination in "$project_root/.agents/skills" "$project_root/.claude/skills"; do
  rm -rf "$destination"
  mkdir -p "$destination"

  while IFS= read -r -d '' skill_file; do
    skill_directory=${skill_file%/SKILL.md}
    skill_name=${skill_directory##*/}
    cp -R "$skill_directory" "$destination/$skill_name"
  done < <(find "$skills_root" -type f -name SKILL.md -print0)
done
