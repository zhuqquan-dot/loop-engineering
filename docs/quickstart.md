# Quick Start

If you have never used Loop Engineering before, this is the fastest path to a working loop.

## Before you start

Understand what you are signing up for. Loop Engineering is not a one-line prompt. It is a structure for repeatable agent work. You are adding process because the task repeats enough to justify it. If it does not repeat, stop here.

## The shortest possible path

### Step 1: Identify a candidate

Pick one task that:
- you do at least 5 times a month
- produces output you can check against clear standards
- will not cause disaster if the AI gets it wrong once

Do not pick something emotionally sensitive, externally facing, or irreversible.

### Step 2: Run the 3 hard gates

From the terminal or your agent conversation:

```text
H1: How many times in the last 30 days? ____
H2: If the AI gets it wrong, is the damage reversible? Who catches it? ____
H3: Does it involve sending, publishing, or calling outside systems? ____
```

If H1 < 5, stop. This task is too infrequent.
If H2 fails, stop. Do not automate things that cannot fail safely.
If H3 is yes, add a human gate before any external action.

### Step 3: Grade the loop

- **L-READ**: you are only reading data and summarizing it locally. Proceed.
- **L-DRAFT**: you are writing drafts or internal files. You need a generator and a separate evaluator.
- **L-ACT**: you are doing external actions. Add a human gate + weekly audits.

### Step 4: Create the minimum structure

```text
project/
├── skills/
│   └── generator-{name}/
│       └── SKILL.md
├── state/
│   └── log.md
```

That is all you need for the first 30 days. Add the evaluator and the full state structure only when you have run stably.

### Step 5: Run it manually for 30 days

Trigger it yourself each time. Do not schedule it. You need to prove that the loop works before you hand it the keys.

### Step 6: Decide

After 30 days, look at your log. Ask yourself:

- Did it run at least 25 times? → upgrade to full structure
- Did it produce useful output most of the time? → keep it
- Did you stop opening the log after week 2? → kill it

## What to expect

The first 2 weeks will feel like extra work. That is normal. You are learning whether the loop is stable.

By week 4, if the loop is working, you will have stopped thinking about it — it will just produce output you can glance at in 30 seconds.

If that has not happened by week 4, the task was probably not a good loop candidate.
