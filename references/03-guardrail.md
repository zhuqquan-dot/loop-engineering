# 03 · Guard: Auto-Downgrade + Evaluator Calibration + State Rolling

## Three automatic mechanisms

### A. 30-day auto-downgrade

**Trigger**: any loop's weekly self-audit has not run for 4 consecutive weeks.

**Downgrade rules**:

| Current level | Downgrades to | Consequence |
|---|---|---|
| L-ACT | L-DRAFT | No more external actions (sending, merging, API calls) |
| L-DRAFT | L-READ | No more file writing |

**Recovery condition**: manually run one complete weekly self-audit with all items green.

**Why this mechanism exists**: an unattended loop should automatically reduce its power, not continue running at full speed in a vacuum. This is how a loop limits damage when it has been abandoned.

---

### B. Evaluator calibration

**Written into the evaluator skill** (not optional):

```yaml
## EVALUATOR CALIBRATION (DO NOT MODIFY WITHOUT RE-AUDIT)
calibration_date: YYYY-MM-DD
calibration_standard: "Assume output is wrong unless proven acceptable"
rejection_rate_target: 10%-25%
last_audit_date: YYYY-MM-DD
strictness_level: high
allow_rewrite: false
```

**Auto-reset rule**:
- 4 consecutive weeks with rejection_rate < 5% → strictness_level auto-resets to high
- User may manually lower the level, but this is recorded and flagged in the next weekly audit

**Why this mechanism exists**: the evaluator is the only component that actually says "no." If it stops saying no for an extended period, the entire loop degrades from maker-checker to maker self-approval. The natural human tendency is to settle for "good enough" — to let yourself off easy. Calibration parameters are the only counterforce.

---

### C. State file rolling (hot-warm-cold)

**Why this mechanism exists**: append-only log files cause the agent to read the entire growing history on every run → the context window fills with months of stale logs → space for real tasks shrinks. See `references/08-hot-warm-cold.md`.

**Three-layer rules**:

| Layer | File | Retention | Agent auto-reads? |
|---|---|---|---|
| Hot | log.md | Last 7 days | Yes |
| Hot | inbox.md | Unprocessed under 30 days | Yes (unprocessed only) |
| Warm | weekly-summary.md | Permanent | On demand |
| Cold | archive/ | Permanent | **No** |

**Weekly rolling process** (executed during Sunday self-audit):

1. Extract last 7 days from log.md → generate 1 summary line → append to weekly-summary.md
2. Move raw 7-day log to `archive/{year}-Q{quarter}/log-{week}.md`
3. Clear log.md, keep only the header
4. Inbox items older than 30 days → move to `archive/{year}-Q{quarter}/inbox.md`
5. **Agent must never auto-read any file under archive/**

---

## Weekly self-audit (loop-audit)

See `templates/evaluator-example/loop-audit.md`. Core four accounts:

| Account | Metric | Red threshold |
|---|---|---|
| Verification backlog | Inbox items over 30 days unprocessed | > 5 items |
| Understanding decay | Consecutive days without review | > 7 days |
| Cognitive surrender | Weekly rejection rate | < 1% |
| Loss of control | Consecutive audits missed | > 4 weeks |

### Liveness signals (prevent null-signal)

To make the weekly audit worth running, the report must contain **non-predictable elements**:

1. **Random spot check**: randomly select 1 output from this week, show a content summary, and ask: "Can you describe what this output did, in one sentence?"
2. **Trend line**: rejection rate trend (rising / falling / flat), not just a single number
3. **Dependency check**: if this loop depends on another loop's output, check whether the upstream was healthy this week

---

## Guard action schedule

### Daily (1 minute)

- Glance at log.md: did it run today?
- If new inbox items exist, quick scan

### Weekly (15 minutes)

- Run one self-audit
- Process inbox (clear or archive)
- Answer the random spot check: do you recognize this output?

### Monthly (30 minutes)

- Review whether evaluator needs tightening
- Review scheduling plan (is Lv1 stable? Time to upgrade to Lv2?)

### Quarterly (2 hours)

- Blind test: stop one loop for a week, see if anything breaks
- Inventory: which loops to delete, merge, or upgrade
- Update expired examples
