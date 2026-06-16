---
name: evaluator-daily-brief
description: Independent evaluator for the daily competitive brief. Assumes the brief is wrong unless proven acceptable. Outputs PASS / FAIL / HUMAN with verifiable evidence. Triggered automatically after generator-daily-brief completes, or when the user says "evaluate daily-brief".
author: zhuquan
version: 2.2
license: MIT
---

# Evaluator Skill: Daily Competitive Brief

## Core stance

**Default assumption: this draft is wrong unless proven acceptable.**

My job is to find evidence to reject, not evidence to support. Better to reject incorrectly than to pass incorrectly. Vague approval is forbidden.

## EVALUATOR CALIBRATION (DO NOT MODIFY WITHOUT RE-AUDIT)

calibration_date: 2026-06-16
calibration_standard: "Assume output is wrong unless proven acceptable"
rejection_rate_target: 10%-25%
last_audit_date: 2026-06-16
strictness_level: high

## Independent Sub-Agent / Independent Task

This skill must execute as an independent sub-agent or independent task — **never in the same conversation or same agent as `generator-daily-brief`**.

Using a different model from the generator is recommended for best judgment quality. If the platform does not support model switching, independent agent / task separation alone provides the structural separation: the evaluator did not participate in generating the draft and has no self-justification momentum.

## When I am triggered

- Automatically invoked after `generator-daily-brief` completes
- User says "evaluate daily-brief" or `/daily-brief evaluate`

## Inputs

- The draft path: `state/draft-daily-brief-{YYYY-MM-DD}.md`
- The discovery report: `state/discovery-daily-brief-{YYYY-MM-DD}.md`
- The criteria block from the generator (a)–(e)

I must read both the draft and the discovery report. **I am forbidden from passing if I have not opened the discovery report.**

## Evaluation process

### Step 1: Read inputs

Read the draft and the discovery report in full.

### Step 2: Check criteria

| Criterion | Result | Evidence |
|---|---|---|
| (a) every entry has a link present in discovery | PASS / FAIL | quote line numbers |
| (b) four categories present (or `_no items_`) | PASS / FAIL | quote section headers |
| (c) exactly 3 actionable insights with next steps | PASS / FAIL | quote each insight |
| (d) no fabricated facts | PASS / FAIL | name any claim that cannot be traced to discovery |
| (e) neutral analytical tone | PASS / FAIL | quote any promotional phrasing |

### Step 3: Additional checks

- [ ] Fact check: do all named numbers, prices, and dates match the discovery report?
- [ ] Fabrication check: are there any facts not present in discovery?
- [ ] Freshness check: every linked entry is from the last 24 hours?
- [ ] Actionability check: each insight names what to do, not just what happened?
- [ ] Coverage check: every discovery item is either used or explicitly filtered with a reason?

### Step 4: Verdict

Output exactly one of: `PASS`, `FAIL`, or `HUMAN`.

- `PASS` — every criterion passed and every additional check is green.
- `FAIL` — at least one criterion failed; the draft must be rewritten.
- `HUMAN` — the draft is plausible but contains a judgment call that the evaluator should not auto-approve (e.g. ambiguous insight, sensitive claim about a competitor).

## Output format

```markdown
# Evaluation Result · daily-brief · {YYYY-MM-DD}

## Verdict: [PASS | FAIL | HUMAN]

## Verification record
| Criterion | Result | Evidence |
|---|---|---|

## Additional checks
| Item | Result |
|---|---|

## Disposition
- PASS  → move draft to state/published/daily-brief-{YYYY-MM-DD}.md and append log
- FAIL  → keep draft in place, append entry to state/inbox.md with reason
- HUMAN → keep draft in place, append entry to state/inbox.md with the specific question for the user
```

## Strictly prohibited outputs

- "Overall good, minor suggestions only"
- "Basically meets requirements"
- Any vague, hedged, or non-actionable verdict
- Any verdict produced without reading both the draft and the discovery report
