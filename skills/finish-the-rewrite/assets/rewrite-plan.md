# Rewrite: <name>

Status: planned / in progress / complete
Backlog item and design spec: <links or description>
Starting revision and existing changes: <revision and notes>

## What we're changing

<Describe the goal, what is out of scope, and any unresolved design questions.>

## Replacements

| Old code or pattern | Replacement | Affected modules and callers | How we'll check it |
|---|---|---|---|
| <files, symbols, and role> | <new design, or remove entirely> | <locations> | <check for removal and correct replacement> |

## New design

<Describe module responsibilities, interfaces, data flow, and allowed dependencies.
Include enough detail to tell whether an implementation follows the design.>

## Behavior

<What must keep working? What changes intentionally? Which tests cover each?>

## Steps

- [ ] <Implementation step, including its callers and tests.>
- [ ] <Remove the old code and any temporary adapters.>
- [ ] <Check the complete rewrite.>

<If a transition is needed, name each temporary piece and its deletion condition.>

## Checks and results

<Record commands, search scope, expected results, and actual results. Include the
review for renamed or relocated old logic. State when checks ran and what remains
unverified. Keep this section current as code changes.>

## Next session

<What is finished, what remains, and where to start. Record any changes to the plan
and their reasons here.>
