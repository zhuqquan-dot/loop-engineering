# Project Rules (rules.md)

> Universal version. Different agents may have different loading mechanisms and filenames — see `adapters/` directory for specific mappings.

## 1. Maker-Checker Separation (L-DRAFT and above)

- Any generator output must be reviewed by an independent evaluator sub-agent/task
- **Strictly prohibit self-review in the same agent or same conversation** — that is the generator self-justifying, not genuine evaluation
- Recommend using a different model for evaluator; if the platform does not support model switching, independent agent structural separation is the minimum acceptable baseline

## 2. External Action Requires Human Gate (L-ACT)

- Any step involving sending, merging, publishing, or calling external APIs must have the final step executed by a human
- AI may only reach "draft / pending review" stage

## 3. State Lives in Files, Not in Memory

- Cross-round state must be persisted to state/*.md
- Strictly prohibit relying on conversation context for cross-round memory

## 4. State File Read Rules

- Must read before every run: state/log.md (last 7 days)
- Read on demand before every run: state/inbox.md (unprocessed items only)
- Prohibit auto-read: any file under state/archive/

## 5. Three-Level Grading Standard

| Level | Characteristics | Core requirement |
|---|---|---|
| L-READ | Read-only | state/log.md only |
| L-DRAFT | Write drafts | generator + independent evaluator sub-agent separation |
| L-ACT | External action | All L-DRAFT requirements + human gate + weekly self-audit |

## 6. Phase Upgrade Rule

- Lv1 (manual trigger) must run stably for 30 days before entering Lv2 (scheduled automation)
- Lv2 must run stably for 60 days before entering Lv3 (cloud scheduling)

## 7. Automatic Downgrade

- 4 consecutive weeks without self-audit → automatic downgrade (L-ACT → L-DRAFT → L-READ)
- Recovery condition: manually run one complete self-audit

## 8. Evaluator Calibration (L-DRAFT and above)

- Evaluator skill must include a CALIBRATION parameter block
- rejection_rate_target: 10%-25%
- 4 consecutive weeks < 5% → strictness_level auto-resets to high

## 9. Weekly Rolling Archive

- Every Sunday: log.md compressed into 1 summary line → weekly-summary.md
- Raw log archived → archive/
- inbox.md items older than 30 days → archived

## 10. When to Stop a Loop

Stop immediately if any of the following is true:
- 4 consecutive weeks of red self-audit
- 7 consecutive days of rejection rate < 1%
- 3 consecutive idle runs (same task FAILs, retried, still FAILs)
- Any single output causes an external incident
- You have not looked at its output for a month

> A loop is your tool, not your master. Turning off an unneeded loop is as important as creating a new one.
