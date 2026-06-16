# 02 · Build: Standard Structure and Three-Level Grading

## Grade first

Before creating any files, determine the loop's level using this matrix:

### L-READ — Read-only reporting

**Characteristics**: reads data sources → generates report/summary → saves as local file only.

Does **not** modify any files, call external APIs that change state, or send messages to anyone.

**Examples**: daily competitor activity brief, weekly data summary, task scanning, topic monitoring.

**Requirements**: `state/log.md` only.

**Allowed**: one skill handles everything (discovery + generator can merge). Same model is acceptable. Same agent is acceptable.

### L-DRAFT — Internal drafts and documents

**Characteristics**: reads + generates + writes local files. Does not send or publish externally.

**Examples**: customer follow-up draft, weekly report first draft, internal FAQ update, knowledge base entries.

**Requirements**:
- Generator and evaluator must be separated as two independent sub-agents or independent tasks
- Recommend using different models for generator and evaluator, but if the platform does not support switching or the cost is high, independent task separation alone provides the necessary structural separation
- `state/log.md` + `state/inbox.md` + `state/weekly-summary.md`

### L-ACT — External action

**Characteristics**: automatic sending, PR merging, external API calls, production database writes.

**Examples**: automated issue creation, automated email reply (after human confirmation), content publishing.

**Requirements**:
- All L-DRAFT requirements plus:
- `rules.md` mandatory
- Final step **must be a human gate**: AI output → human confirms → then execute
- Weekly self-audit mandatory (continuous 4 weeks missed → automatic downgrade to L-DRAFT)

### Edge rule

If you cannot decide between two levels, default to the higher one. It is always safer to over-guard than under-guard.

---

## Standard file structure

```
project/
├── skills/
│   ├── discovery-{name}/          # Discovery (find work)
│   │   └── SKILL.md
│   ├── generator-{name}/          # Generator (do work)
│   │   └── SKILL.md
│   └── evaluator-{name}/          # Evaluator (say no) — optional for L-READ only
│       └── SKILL.md
├── state/
│   ├── log.md                     # Hot: last 7 days
│   ├── inbox.md                   # Hot: pending items under 30 days
│   ├── weekly-summary.md          # Warm: weekly compressed summaries
│   └── archive/                   # Cold: agent must not auto-read
├── rules.md                       # Project rules
└── README.md                      # Business context
```

### State file rules (see 08-hot-warm-cold.md for details)

| File | Retention | Overflow handling | Agent reads every run? |
|---|---|---|---|
| log.md | 7 days | Sunday compress → weekly-summary.md | Yes |
| inbox.md | 30 days | Expired → archive/ | Yes (unprocessed only) |
| weekly-summary.md | Permanent | None | On demand |
| archive/ | Permanent | Yearly archive | No |

---

## Five actions mapped to skills

| Action | Purpose | Implementation |
|---|---|---|
| 1. Discover | Scan data sources, find work to do | `discovery-*/SKILL.md` |
| 2. Deliver | Isolate each discovery into independent work | Each task is a fresh isolated run |
| 3. Verify | Have a separate agent judge the output | `evaluator-*/SKILL.md` |
| 4. Persist | State goes to disk | `state/*.md` |
| 5. Schedule | Make it run repeatedly | Lv1 manual → Lv2 system timer → Lv3 cloud |

---

## Generator / Evaluator separation rules

### What a generator skill must never contain

- "Self-review after writing"
- "Check whether quality standards are met"
- Any form of self-evaluation

The generator only needs to: read discovery → generate draft → invoke evaluator → finish.

### What an evaluator skill must contain

- "Default assumption: this output is wrong unless proven acceptable"
- Check against each observable criterion from S1
- Output only three verdicts: PASS / FAIL / HUMAN
- Strictly prohibit vague language ("overall good", "minor suggestions")
- Include calibration parameters: calibration_date, rejection_rate_target, strictness_level

### Model separation (recommended, not required)

- Recommend using models from different vendor families for generator and evaluator
- If the platform does not support model switching or the cost is too high — this is not a problem. Structural independent sub-agent/task separation already provides the core value: the evaluator did not participate in generation and has no self-justification momentum
- Strictly prohibited: both sides use the same model **and the same agent (i.e., generator self-reviews)**

---

## Scheduling progression

| Phase | Trigger method | When |
|---|---|---|
| Lv1 Manual | Human triggers once per run | Starting phase for all loops |
| Lv2 Timer | Phone shortcut / desktop timer / cron | After 30 days stable manual operation |
| Lv3 Cloud | CI/CD pipeline / cloud scheduled task | Runs even when machine is off |

> Iron rule: Lv1 must run stably for 30 days (continuous run records + all audits green) before entering Lv2.

---

## Build completion checklist

Before entering Phase 3, confirm:

- [ ] Loop level determined
- [ ] Required skill files created according to level (discovery / generator / evaluator)
- [ ] `state/log.md` created (empty, with header)
- [ ] `state/inbox.md` created (L-DRAFT+)
- [ ] `state/weekly-summary.md` created (L-DRAFT+)
- [ ] `rules.md` created (L-ACT+)
- [ ] Scheduling method determined (at least Lv1)
- [ ] One quick command or one-click trigger configured
