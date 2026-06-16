# Memory and State Management

Long-running agent loops have a hidden failure mode that most people discover only after months of operation: the context window slowly fills with old logs, and the agent's effective working memory shrinks.

This document explains the hot-warm-cold model and why it is necessary.

## The problem with append-only logs

If you append one line to `log.md` every time a loop runs, and the agent reads the entire file on each run:

- Day 30: approximately 1200 tokens of log
- Day 180: approximately 7200 tokens of log
- Day 365: approximately 14600 tokens of log

For an agent with a limited context window, this means the space available for the actual task shrinks proportionally. The loop gradually becomes less capable not because the task changed, but because the agent is spending more attention on its own history than on the current work.

## The hot-warm-cold model

### Hot layer — active working state

**Files**: `state/log.md` (last 7 days), `state/inbox.md` (unprocessed items under 30 days)

The agent reads these on every run. This is the smallest and most current slice of state.

### Warm layer — compressed history

**File**: `state/weekly-summary.md`

Each week, the last 7 days of `log.md` are compressed into a single summary line and appended here. The agent reads this on demand, not by default.

### Cold layer — archived history

**Directory**: `state/archive/`

Raw logs and processed inbox items that are older than the retention windows. The agent is explicitly forbidden from reading this directory automatically. These files exist for human audit, not for agent context.

## The weekly rolling process

Every Sunday during the weekly audit:

1. Read the last 7 days of `log.md`
2. Generate one summary line: `W{week}: ran {N} times, PASS {X}, FAIL {Y}, main failure cause={reason}`
3. Append the summary to `weekly-summary.md`
4. Move the raw 7-day log entries to `archive/{year}-Q{quarter}/log-{week}.md`
5. Clear `log.md`, keeping only the header
6. Move inbox items older than 30 days to `archive/{year}-Q{quarter}/inbox-archived.md`

## The agent read rule

This rule must be written into the project's `rules.md` or equivalent:

```markdown
## State file read rules
### Always read on every run
- state/log.md (last 7 days, hot layer)

### Read on demand
- state/inbox.md (only unprocessed items)
- state/weekly-summary.md (only when historical context is needed)

### Do not read automatically
- state/archive/ — any file
- Inbox items older than 30 days
```

## Why this is not optional for long-running loops

Without rolling state, every long-running loop eventually enters a decay phase where it spends more effort managing its own history than performing its actual task.

This is not a theoretical concern. It is the most common reason that loops that worked perfectly for months suddenly start producing degraded output.

The fix is not a bigger context window. The fix is a discipline that prevents context from growing unbounded in the first place.
