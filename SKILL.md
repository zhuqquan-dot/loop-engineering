---
name: loop-engineering
description: A full methodology for deciding when repeated AI work should become a loop, how to grade risk, how to separate generation from evaluation, how to preserve state outside chat context, and how to keep human control over consequential action. Use when users ask for automation, repeated agent workflows, loops, recurring tasks, agent self-running systems, or durable AI operating methods across Claude Code, Codex, Cursor, Trae, and similar environments.
author: zhuquan
version: 2.2
license: MIT
---

# Loop Engineering Skill v2.2

This is a meta-skill. It does not perform the domain task for you. It defines how to design, build, guard, and reuse a repeatable AI agent loop.

This skill is intentionally complete. It is not a minimal prompt. Use it when structure matters more than speed.

## What this skill is for

Use this skill when the user is describing repeated work rather than a one-off request, especially when they say things like:

- automate this
- run this every day or every week
- let the agent handle this loop
- make this reusable
- turn this into a recurring workflow
- build a repeatable agent process

Use it when the real problem is not just the task itself, but the operating method around the task.

## What this skill is not for

Do not use this skill by default for:

- one-off tasks
- lightweight brainstorming
- emotionally sensitive personal communication
- major strategic judgment that should stay fully human-led
- tasks where process overhead is higher than the error risk

## Core judgment

Not every task deserves a loop.

A loop is justified only when repeated work benefits from structure, visible success criteria, separated checking, and controlled state.

## Operating sequence

```text
1. Clarify whether the task should become a loop
2. Grade the loop by risk and consequence
3. Build generator / evaluator / state structure
4. Add guardrails before increasing automation
5. Reuse only after the loop has run stably
```

## Phase 1 — Clarify

Apply the 3 hard gates and 2 soft prompts from [`references/01-clarify-3plus2.md`](./references/01-clarify-3plus2.md).

The purpose is not to force process onto every task. The purpose is to reject bad loop candidates early.

A good loop candidate is repeated, checkable, and survivable when something goes wrong.

## Phase 2 — Build

Apply the grading and structure rules from [`references/02-build-spec.md`](./references/02-build-spec.md).

### Grading model

- **L-READ**: read-only
- **L-DRAFT**: internal drafts or local writing, but no external action
- **L-ACT**: external action, publishing, sending, merging, production updates, outside system calls

If uncertain, grade higher.

### Non-negotiable rules

1. For **L-DRAFT** and **L-ACT**, generator and evaluator must be separated into independent agents or independent tasks
2. The evaluator assumes the output is wrong unless it proves acceptable
3. External action requires a human gate
4. Manual operation must stabilize before scheduled automation
5. Different models may help, but structural separation matters more than model choice

## Phase 3 — Guard

Apply the guardrail rules from [`references/03-guardrail.md`](./references/03-guardrail.md).

A loop that runs without maintenance becomes dangerous. Guardrails exist to stop silent decay.

The guard layer includes:

- downgrade rules
- evaluator calibration
- weekly audit
- state file rolling

## Phase 4 — Reuse

Apply the reuse rules from [`references/04-reuse.md`](./references/04-reuse.md).

Only reuse a loop after it has run stably long enough to deserve copying. Reuse is earned, not assumed.

## State discipline

Long-running loops should preserve state in files, not in endless chat context.

Use the rolling-state model described in [`references/08-hot-warm-cold.md`](./references/08-hot-warm-cold.md):

- hot state for active operation
- warm summaries for compressed memory
- cold archive for history that should not be auto-read

## Evaluator doctrine

The evaluator is not decoration.

It exists because generators self-justify. A second independent agent or independent task must examine the output without sharing the generator's momentum. If platform features do not support automatic model switching, that is acceptable. Use independent task separation instead.

See also:

- [`references/05-anti-patterns.md`](./references/05-anti-patterns.md)
- [`templates/evaluator-example/SKILL.md`](./templates/evaluator-example/SKILL.md)

## Cross-agent use

This skill is designed to remain stable across platforms. Platform-specific execution details belong in `adapters/`, not in the core method.

Read the adapter that matches the user environment:

- [`adapters/claude-code.md`](./adapters/claude-code.md)
- [`adapters/codex.md`](./adapters/codex.md)
- [`adapters/cursor.md`](./adapters/cursor.md)
- [`adapters/trae.md`](./adapters/trae.md)

## Refusal rules

Refuse or push back when:

1. there is no evaluator for L-DRAFT or above
2. generator and evaluator are the same agent in the same task context
3. external action is requested without a human gate
4. the task is too infrequent to deserve loop overhead
5. the user is disguising a risky action as a low-risk loop

## Reading map

- start here: [`README.md`](./README.md)
- implementation logic: [`references/`](./references/)
- reusable patterns: [`templates/`](./templates/)
- platform mapping: [`adapters/`](./adapters/)
- concrete examples: [`examples/`](./examples/)
- public repo narrative: [`docs/`](./docs/)

## Final rule

Structure over magic.

A good loop is not the one that sounds the smartest. It is the one that can run repeatedly without quietly becoming wrong.
