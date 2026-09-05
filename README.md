# Agent Skills

A small collection of portable skills for AI agents, following the open
[Agent Skills specification](https://agentskills.io/specification).

## Available skills

- [`add-agent-config-sync`](skills/add-agent-config-sync/) — Add a small script that mirrors
  skills from any project-chosen source directory into ignored agent directories.
- [`audit-agent-instructions`](skills/audit-agent-instructions/) — Audit project agent rules
  and skills for contradictions and write a concise root-level Markdown report.
- [`finish-the-rewrite`](skills/finish-the-rewrite/) — Plan and carry out code rewrites,
  checking that the new design works and the old implementation is fully removed.
- [`grill-me`](skills/grill-me/) — Stress-test a plan or design through focused questions
  until its decision branches and dependencies are resolved.

See [CONTRIBUTING.md](CONTRIBUTING.md) for authoring and validation conventions.

## License

[MIT](LICENSE).
