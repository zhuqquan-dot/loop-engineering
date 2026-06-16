# Example: Daily Competitive Intelligence Loop

A complete L-READ level loop case study, demonstrating how to apply Loop Engineering to a real business task.

You can fork from here, replacing the placeholders with your own business context.

## Files in this example

This directory ships a complete, runnable example. After installing the loop-engineering skill, you can copy the four files below into your project and adapt them.

| File | Purpose |
|---|---|
| [`skills/discovery-daily-brief.md`](./skills/discovery-daily-brief.md) | Read-only scan over the 5 competitor accounts, produces the day's discovery report |
| [`skills/generator-daily-brief.md`](./skills/generator-daily-brief.md) | Turns the discovery report into a 4-category brief with insights |
| [`skills/evaluator-daily-brief.md`](./skills/evaluator-daily-brief.md) | Independent evaluator: assumes the brief is wrong unless proven acceptable |
| [`state/log.md`](./state/log.md) | Trial log skeleton with the first three example rows |

The skills are paired (discovery → generator → evaluator) and follow the standard naming conventions in [`templates/`](../../templates/). Replace the source list and review criteria with your own.

## How to run it

```bash
# from the loop-engineering repository root, after the one-line install
./install.sh claude-code --scope project --project-dir ~/work/competitive-intel --with-state --with-rules

# then copy the example skills into the project
mkdir -p ~/work/competitive-intel/.claude/skills/daily-brief
cp examples/daily-brief/skills/*.md ~/work/competitive-intel/.claude/skills/daily-brief/
cp examples/daily-brief/state/log.md ~/work/competitive-intel/state/

# finally, ask the agent: "Run discovery-daily-brief"
```

## Business context

- Applicable roles: Operations / Sales / Product
- Pain point: spending 30–60 minutes daily manually scanning 5 core competitor accounts
- Goal: produce an automated "5-competitor 24h brief" every morning at 9:00 AM, with 4 categories of summary + actionable insights

## Clarification record

| Item | Response | Verdict |
|---|---|---|
| H1 Frequency | Daily × 30 = 30 times | Passed |
| H2 Risk | Internal reference only, reversible | Passed |
| H3 External | No external action | Passed |
| S1 Criteria | (a) each entry includes a link (b) organized into 4 categories (c) 3 actionable insights | Passed |
| S2 Review | Committed to 5 minutes review each morning | Passed |

→ All 3 hard gates passed → Level: **L-READ**

## Level and structure

- Level: L-READ
- Files: 1 skill + state/log.md

## Model

- Generation/discovery model: choose based on each agent's recommendations (see adapters/)

## Scheduling

- Phase 1 (first 30 days): Lv1 manual trigger
- Phase 2 (days 30–60): Lv2 system timer

## 30-day data (fill in after stability)

| Metric | Value |
|---|---|
| Trigger count | __ |
| Time saved | __ minutes/day |
| Issue count | __ |

## Pitfalls encountered (fill in as you go)

- Pitfall 1: __
- Pitfall 2: __

## Upgrade milestones

- [ ] D7: First stable week completed
- [ ] D30: Full 30 days reached → enter reuse phase
- [ ] D60: Forked and reused in a second project
