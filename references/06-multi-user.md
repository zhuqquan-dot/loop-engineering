# 06 · Multi-User Governance (Collaboration Reference)

> This chapter is an **optional reference**. The current version of the Loop Engineering Skill is designed primarily for single-user use. Multi-user deployment requires additional organizational conventions.

## Applicability

Reference this chapter when any of the following is true:

- At least 2 people maintain separate loops in the same project
- The same repository is shared by multiple people
- Loop A's output is used as Loop B's input

## Shared rules file (rules.md) modification protocol

When multiple people may modify rules.md:

1. Changes must go through PR (not direct file edits)
2. At least 1 other maintainer must approve before merge
3. Changes affecting cross-loop impact (model selection, directory structure) must tag all loop maintainers

## Inbox deduplication

Convention: each loop's inbox filename includes the loop name:

`state/{loop-name}-inbox.md`

During weekly self-audit, deduplicate across all inboxes:

- Same issue tracker ID with FAIL → merge into 1 item
- Mark in weekly-summary.md: "repeated across N loops"

## Cross-loop dependency declaration

Declare dependencies in the generator or discovery skill header:

```yaml
# dependencies:
#   - discovery-daily-brief   (upstream: competitive intelligence discovery)
#   - evaluator-daily-brief   (upstream: competitive intelligence evaluation)
```

Dependency check rules:

- Generator checks whether upstream evaluator passed today before running
- Upstream not passed → pause, log "pending upstream: {name}"

## Shared models and evaluator reuse

- Recommend all loops share the same evaluator model to reduce management complexity
- Do NOT recommend sharing the same evaluator skill → one evaluator loosened → affects all loops
- If sharing is necessary: make evaluator skill read-only, centralized modification authority to one person

## Current limitations

The following capabilities are not supported in v2.0:

- Unified cross-loop budget management
- Merged multi-user weekly audit report
- Automatic cross-loop orchestration (DAG)

> If multi-user scenarios are unavoidable, recommend starting with everyone sharing one rules.md, each maintaining their own state/, and one person rotating weekly to run the full audit.
