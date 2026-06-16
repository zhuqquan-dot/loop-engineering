# The Three-Level Grading Model

The grading model is how Loop Engineering matches process intensity to risk. It is the single most important decision you make when building a loop.

## Why three levels

Two levels would be too coarse. Five would be too many to remember.

Three levels map cleanly onto the most important boundary in agent workflows: the line between internal work and external action.

## L-READ — Read-Only Loops

### Definition
The loop reads data sources, generates a summary or report, and writes it to a local file. It does not modify any existing files, does not call external APIs in a way that changes state, and never sends anything to anyone.

### Examples
- Daily competitor activity summary
- Weekly data aggregation
- Scanning a set of sources for mentions of a topic
- Generating an internal overview from multiple inputs

### Requirements
- `state/log.md` only
- One skill can handle both discovery and generation
- Same model is acceptable
- Same agent is acceptable

### What L-READ is not
- Anything that writes to a shared or production file
- Anything that sends a message, email, or notification
- Anything that triggers a downstream system

## L-DRAFT — Draft Generation Loops

### Definition
The loop reads sources, generates draft content, and writes it to local files. The content is meant for internal use and can be reviewed before any external use.

### Examples
- Customer follow-up message drafts
- Weekly report first drafts
- Internal FAQ answer generation
- Proposal drafts
- Knowledge base entry generation

### Requirements
- Generator and evaluator must be separated as independent agents or independent tasks
- `state/log.md` + `state/inbox.md` + `state/weekly-summary.md`
- Evaluator assumes output is wrong unless proven acceptable
- Different models for generator and evaluator are recommended but not mandatory. Structural separation is the non-negotiable requirement.

### Common failure mode
The most common failure in L-DRAFT loops is treating the draft output as finished work. The evaluator exists precisely because generator output looks convincing even when it is wrong.

## L-ACT — Action Loops

### Definition
The loop performs external actions: sending messages, publishing content, merging code, updating production data, calling external APIs with side effects.

### Examples
- Automated email sending (with human confirmation)
- Content publishing workflows
- PR merging automation
- Production database updates

### Requirements
- All L-DRAFT requirements plus:
  - `rules.md` is mandatory
  - The final step must be a human gate — AI drafts, human confirms, AI executes
  - Weekly self-audit is mandatory
  - Continuous 4 weeks without audit triggers automatic downgrade to L-DRAFT

### Why L-ACT is dangerous
External action is the only boundary in a loop that cannot be undone by reverting a local file. Once something is sent, published, or merged, there is no rollback. The human gate is not a suggestion.

## The edge rule

If you cannot decide between two levels, choose the higher one.

It is always safer to over-guard than under-guard. A loop that adds one unnecessary gate wastes 5 seconds. A loop that is missing a necessary gate can waste hours of cleanup.

## Progression

- Start at the level that matches the actual task
- Do not start at a lower level to avoid process. That is called disguise, and it is an anti-pattern.
- If a loop's scope expands, re-grade it immediately
