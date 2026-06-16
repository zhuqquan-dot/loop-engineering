---
name: loop-audit
description: Loop weekly self-audit skill. Performs a four-account health check (verification backlog / understanding decay / cognitive surrender / loss of control), outputs trend lines and random spot checks. Triggered when user says "loop audit", "weekly self-audit", or at a fixed weekly time.
author: zhuquan
version: 2.2
---

# Loop Weekly Self-Audit Skill

## My input

Scan all hot-layer files under `state/`:

- log.md (last 7 days)
- inbox.md (unprocessed items)
- weekly-summary.md (historical trends)

**Prohibited from reading** any file under `state/archive/`.

## My output format

```markdown
# Loop Weekly Self-Audit · {YYYY-MM-DD}

## 1. Verification Backlog [green / yellow / red]
- Inbox unprocessed: X items
- Over 30 days unprocessed: X items
- Verdict: {threshold}

## 2. Understanding Decay [green / yellow / red]
- Runs this week: X
- Consecutive days without review (inferred from log): X
- Random spot check of 1 output: "{content summary}"
  → Can the user describe what it did in one sentence? [yes / no]

## 3. Cognitive Surrender [green / yellow / red]
- PASS count this week: X
- FAIL count this week: X
- Rejection rate: X%
- Trend: {rising / falling / flat}
- Consecutive weeks below 5%: X
  → If ≥ 4 weeks: evaluator strictness_level auto-resets to high

## 4. Loss of Control [green / yellow / red]
- Consecutive weeks without self-audit: X
- If ≥ 4 weeks: auto-downgrade triggered ({L-ACT→L-DRAFT} / {L-DRAFT→L-READ})

## Overall Assessment
- Overall health: [green / yellow / red]
- Must handle this week: [list red items + specific actions]
- Watch next week: [list yellow items]
```

## Automatic actions

- 4 consecutive weeks without self-audit → auto-downgrade (see references/03-guardrail.md)
- Weekly rejection rate < 5% for 4 consecutive weeks → evaluator strictness_level auto-resets to high
- Weekly rolling: log.md last 7 days → weekly-summary.md compressed summary → archive raw log

## Upgrade trigger

All audit items green + 30 days stable → recommend entering Phase 4 harvesting.

## Liveness signals

- Random spot check: randomly select 1 output each cycle and show a content summary
- Trend line: rejection rate must include a direction arrow, not just a number
- Dependency check: if this skill detects upstream loop markers, check their status this week
