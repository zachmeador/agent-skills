---
name: finish-the-rewrite
description: >-
  Plan, carry out, or review a code rewrite using a Markdown file that describes
  what gets replaced, what replaces it, and how to check the work. Use when the
  user wants to replace an existing design, migrate a subsystem, or verify that
  an old implementation has been fully removed.
---

# Finish the Rewrite

Write the rewrite plan to a Markdown file. Use it throughout the work to track what
must change and what still needs checking. A large diff is acceptable when the
requested design requires it.

## Plan the rewrite

Read the backlog item, design spec, and affected code. Follow callers and data flow
far enough to find the modules that depend on the old design. Include tests,
configuration, stored data, and external consumers where relevant.

Use [the template](assets/rewrite-plan.md) to write one plan in the project's
usual planning directory, or `docs/rewrites/<name>.md` if there isn't one. Cover:

- What the rewrite should accomplish and what is outside its scope.
- Which modules change, which old types, interfaces, and patterns disappear, and
  what replaces each one. Name actual files and symbols.
- How the new design works: what each module owns, how data moves, and which
  dependencies are allowed. Link the design spec if one exists.
- Which behavior must stay the same and which changes are requested. Treat other
  behavior changes as questions to resolve, including bugs discovered along the way.
- How to check that the new design works and the old design is gone.

Resolve design questions that would materially change the rewrite before coding.
If the user only asked for a plan, stop after writing it. If they asked for the
rewrite, continue once the plan is clear.

## Carry out the rewrite

Read the plan at the start of each session and check progress against the code.
Record the starting revision and any existing changes so the final review can
distinguish the rewrite from other work.

Implement the specified design, updating all affected callers. Do not shrink the
rewrite to preserve existing file boundaries or make the diff smaller. If a new
module merely translates calls back into the old implementation, the replacement
is still unfinished.

When the code can change together, replace it together. If deployment or external
consumers require a transition, record each temporary adapter or fallback, why it
is needed, and when it will be deleted. The full rewrite is unfinished while those
pieces remain.

Remove obsolete implementations, exports, configuration, and dependencies as their
uses disappear. Update tests to cover the required behavior through the new design;
keep their useful assertions. Do not weaken tests or narrow checks to get a pass.
Ask before deleting stored data, rewriting history, or making a production change.

When a discovery changes the plan, explain it in the file. Ask the user if it changes
the agreed scope or design. Do not change the requirements to excuse an incomplete
implementation. Before ending a session, record what changed, what was checked,
and what should happen next.

## Check the result

For each planned replacement:

1. Search the current project for old names, imports, configuration keys, and
   distinctive code patterns. Include new and untracked files. Explain remaining
   matches, such as historical migrations or the rewrite plan itself.
2. Read the new implementation and follow its callers. Check for old logic that was
   renamed, copied into a helper, wrapped, or left behind a flag. A search returning
   no matches does not establish that the design changed.
3. Check the new module boundaries and data flow against the spec. Use existing
   type checks, dependency rules, or a focused architecture test where useful.
4. Run tests for the required behavior and the relevant project build and checks.
   Record the commands and actual results next to the planned checks.

Where practical, make a check fail on the old implementation before relying on it
to verify the replacement. Read the final diff, including new files, and rerun any
checks affected by subsequent edits.

Mark the rewrite complete only when every planned replacement is checked and no
unplanned legacy code or temporary bridge remains. State any verification you could
not perform; keep that work listed as unfinished. If asked to review a rewrite,
follow these checks and report findings without changing the implementation.
