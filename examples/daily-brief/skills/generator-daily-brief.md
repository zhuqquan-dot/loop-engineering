---
name: generator-daily-brief
description: Daily competitive intelligence generator skill. Used when the user confirms after discovery completes, or says "generate daily-brief from {discovery report}". Turns the discovery report into a 4-category brief with 3 actionable insights. After generation, must invoke evaluator-daily-brief.
author: zhuquan
version: 2.2
license: MIT
---

# Generator Skill: Daily Competitive Intelligence

> Replace the four categories and the insight criteria in this file with your own taxonomy before installing.

## When I am triggered

- After `discovery-daily-brief` completes and the user confirms
- User says "generate daily-brief from {report path}"
- User calls `/daily-brief generate`

## Independent Sub-Agent / Independent Task

After this skill completes, an **independent evaluator sub-agent (or independent task)** must be triggered to evaluate the output. Self-review in the same conversation is not allowed.

Using a different model for the evaluator is recommended for best results. The minimum requirement is a different agent or a fresh task.

## My workflow

1. Read the latest `state/discovery-daily-brief-{YYYY-MM-DD}.md`.
2. Group the entries into the four categories below.
3. For each category, write a 1–3 sentence summary that answers "what changed and why we should care".
4. Produce exactly **3 actionable insights** at the end. Each insight must be specific enough to be assigned to a person.
5. Write the draft to `state/draft-daily-brief-{YYYY-MM-DD}.md`.
6. Invoke `evaluator-daily-brief` (independent sub-agent / task) and pass the draft path plus the criteria block.

## Categories

1. **Product & shipping** — releases, changelogs, deprecations.
2. **Pricing & packaging** — plan changes, free-tier moves, bundles.
3. **Positioning** — messaging shifts, new audience claims, comparison content.
4. **Hiring & org** — public hiring posts that signal direction (e.g. "head of growth", "ML infra lead").

If a category has no items today, write `_no items_` rather than fabricating.

## Output format

```markdown
# Daily Competitive Brief · {YYYY-MM-DD}

## 1. Product & shipping
- {summary, with link}

## 2. Pricing & packaging
- {summary, with link}

## 3. Positioning
- {summary, with link}

## 4. Hiring & org
- {summary, with link}

## Insights (3)
1. {actionable insight, with concrete next step}
2. ...
3. ...

## Source map
| Category | Source | URL |
|---|---|---|
```

## Criteria to be evaluated

Pass these to the evaluator verbatim:

- (a) Every entry has a working link from the discovery report.
- (b) The 4 categories are present, even if marked `_no items_`.
- (c) Exactly 3 actionable insights, each with a concrete next step.
- (d) No fabricated facts: every claim must be traceable to an entry in the discovery report.
- (e) Tone is neutral and analytical, not promotional.

## What I must never do

- Write a "self-review" or "quality check" section — that belongs to the evaluator
- Add new entries that were not in the discovery report
- Send anything externally
- Skip the evaluator handoff

## After generation completes

Immediately prompt: `Generated draft at state/draft-daily-brief-{YYYY-MM-DD}.md. Invoking evaluator-daily-brief now (independent sub-agent).`
