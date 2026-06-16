---
name: generator-NAME
description: Generator skill template. Used when the user confirms after discovery completes, or explicitly says "start generating". Responsible for turning discovered items into draft output. After generation, must actively invoke the evaluator. Replace `NAME` with the business slug (lowercase, kebab-case) before installing this skill.
author: zhuquan
version: 2.2
---

> **Template note**: This file is a copy-and-rename starter. Before installing it as a real skill, replace every literal `NAME` and `{Business Name}` with your loop's slug and human-readable name. The frontmatter `name` field must be a single valid slug — no curly braces.

# Generator Skill: {Business Name}

## When I am triggered

- After discovery-{name} completes and user confirms
- User says "generate {name} from the discovery report"
- User calls /{name}-generate

## Independent Sub-Agent / Independent Task

After this skill completes, **an independent evaluator sub-agent must be triggered to evaluate** — self-review in the same conversation is not allowed.

Using a different model for the evaluator is recommended for best results, but the minimum requirement is **a different agent**.

## My workflow

1. Read the discovery report
2. For each discovery item, create a separate task to generate output
3. Output to `state/draft-{name}-{YYYY-MM-DD}-{seq}.md`
4. **Must actively invoke evaluator-{name} (independent sub-agent)**

## What I must never do

- Write "self-review" or "quality check" in my own skill — that is the independent evaluator agent's job
- Send anything externally
- Self-examine in the same conversation after generating

## Output format

```markdown
# {Business Name} Draft · {Date} · #{Seq}

## Source
{Discovery item #X}

## Content
{Business output}

## Criteria to be evaluated
- Criterion 1: {from clarification phase S1}
- Criterion 2: ...
```

## After generation completes

Immediately prompt: "Generated N drafts. Please invoke evaluator-{name} for evaluation."
