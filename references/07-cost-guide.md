# 07 · Cost Control (Optional Reference)

> This chapter is an **optional reference**. Use only when:

- Your AI product charges by token volume (e.g., API key direct connection)
- Your loop consumption exceeds your expectations
- You want to actively manage usage

If your product is subscription-based (e.g., flat monthly coding plan / agent plan), skip this chapter — the product already has built-in cost control.

## Budget file (create on demand)

If you decide to set a budget, fill in `state/budget.md`:

```markdown
# Optional budget cap

max_tokens_per_day: 100000
max_runs_per_day: 10
max_concurrent_tasks: 3

# Stop conditions
- Single-day tokens exceed 80k → pause all loops
- 3 consecutive FAILs → pause this loop
- inbox > 10 unprocessed items → pause (cognitive surrender signal)
```

## Usage

Add one line to rules.md or at a key step in each skill:

> "Check state/budget.md before running. If exceeding limits, stop this run and record."

## Notes

- Most agent platforms do not expose per-run token consumption to skills
- The budget above is more about **constraining behavior** (limiting run count) than **precise counting**
- If your platform supports billing alerts (e.g., API platform backend billing alert), use the platform's native feature first
- Do not turn this file into a barrier to building loops — treat it as an "anchor point" for the day you need to audit spending

## Idle detection

If you suspect a loop is wasting resources:

- Check weekly-summary.md for tasks with consecutive FAILs
- Same task consecutive FAIL ≥ 3 times → pause that loop → manual fix required before restart
