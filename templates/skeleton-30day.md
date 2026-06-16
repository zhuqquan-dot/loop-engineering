# 30-Day Trial Skeleton

> Don't want to build the full structure from day one? Use the minimum set of files for 30 days. Upgrade only after you have proven it runs stably.

## You only need 2 files

```
project/
├── skills/
│   └── {name}-trial/          # One skill that handles discovery + generation
│       └── SKILL.md
└── state/
    └── log.md                  # One file for logging
```

## Skill template (skills/{name}-trial/SKILL.md)

```markdown
---
name: NAME-trial
description: {One sentence describing what this trial loop does}
author: zhuquan
version: trial-30day
---

# {Business Name} · 30-Day Trial

> **Template note**: replace every literal `NAME` and `{Business Name}` with your loop's slug and human-readable name before installing.

## Trigger
- User manually says "/NAME" or "run NAME"

## Instructions
1. {Data source 1: where to read information from}
2. {What to do: what to generate, where to write it}
3. Write result to state/log.md:
   [YYYY-MM-DD HH:mm] Run complete | output={file} | self-assessment={OK / has issue}

## Restrictions (30-day trial period)
- Do not modify any existing files
- Do not send anything externally
- Only write to state/log.md (one new file)

## After 30 days
- Auto-prompt user: decide to scrap / upgrade to full version / keep as trial
```

## Log file (state/log.md)

```markdown
# Trial Log

[YYYY-MM-DD HH:mm] Run complete | output=draft-YYYY-MM-DD.md | self-assessment=OK
[YYYY-MM-DD HH:mm] Run complete | output=draft-YYYY-MM-DD.md | self-assessment=missing source links

## 30-day expiration date
YYYY-MM-DD (after expiration: scrap / upgrade / keep)
```

## Upgrade signals

At 30 days, check log.md to decide:

| Signal | Recommendation |
|---|---|
| Ran ≥ 25 times | Upgrade to full version |
| Self-assessed "has issue" ≥ 5 times | Needs an evaluator |
| Ran < 10 times | Does not need a loop, downgrade to quick command |
| You never opened log.md | Does not need a loop |

## Upgrading to full version

If you decide to upgrade:
1. Re-run loop-engineering Phase 1 (3 hard gates)
2. Determine level (L-READ / L-DRAFT / L-ACT)
3. Build the complete structure per Phase 2
4. Migrate the last 7 days of trial log.md into the new log.md
