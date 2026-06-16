# 08 · State File Rolling (Hot-Warm-Cold)

This mechanism addresses a severely underestimated problem: **when an agent reads 6 months of logs on every run, the context window fills up, leaving no room for the actual task.**

## Why rolling is necessary

- log.md is designed as append-only — Day 30 has 150 lines, Day 180 has 900 lines
- If the agent reads the entire file every time, context token consumption goes from O(1) to O(time)
- For agents with limited context windows, this means **as time passes, effective working memory keeps shrinking**

## Three-layer design

| Layer | Directory/File | Retention policy | Agent auto-reads? |
|---|---|---|---|
| Hot | state/log.md | Last 7 days. Rolling overwrite. | Yes |
| Hot | state/inbox.md | Last 30 days unprocessed items. | Yes (unprocessed only) |
| Warm | state/weekly-summary.md | 1 summary line per week, permanent. | On demand (agent determines if historical context is needed) |
| Cold | state/archive/ | Raw logs and processed items. | **Do not auto-read** |

## Weekly rolling process

Execute during the Sunday self-audit (written into the loop-audit skill's automatic logic or rules.md):

1. **log.md → weekly-summary.md**
   - Read all entries from the last 7 days in log.md
   - Generate 1 summary line, format: `W{week}: ran {N} times, PASS {X}, FAIL {Y}, main FAIL cause={reason}, notes={optional}`
   - Append to weekly-summary.md

2. **log.md → archive (raw log archived)**
   - Append 7 days of raw records to `archive/{year}-Q{quarter}/log-full.md`
   - Clear log.md, keeping only the header

3. **inbox.md → archive (expired items marked)**
   - Scan inbox.md for items older than 30 days
   - Move to `archive/{year}-Q{quarter}/inbox-archived.md`
   - Mark original location: "archived on {date}"

## Agent read directive

Write this into rules.md:

```markdown
# State file read rules
## Must read before every run
- state/log.md (last 7 days hot layer)

## Read on demand
- state/inbox.md (only when unprocessed items exist)
- state/weekly-summary.md (agent determines if historical context is needed)

## Prohibited auto-read
- Any file under state/archive/
- Inbox items older than 30 days
```

## Effect

| Time | Without rolling: agent reads per run | With rolling: agent reads per run |
|---|---|---|
| Day 7 | ~280 tokens | ~280 tokens |
| Day 30 | ~1200 tokens | ~280 tokens |
| Day 180 | ~7200 tokens | ~280 tokens |
| Day 365 | ~14600 tokens | ~280 tokens |

> Context consumption goes from O(n) to O(1).
