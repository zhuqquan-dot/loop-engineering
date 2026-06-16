---
name: discovery-NAME
description: Discovery skill template. Responsible for scanning data sources and identifying items that need processing this round. Used when the user calls the matching slash command or on a scheduled trigger. Replace `NAME` with the business slug (lowercase, kebab-case) before installing this skill.
author: zhuquan
version: 2.2
---

> **Template note**: This file is a copy-and-rename starter. Before installing it as a real skill, replace every literal `NAME` and `{Business Name}` with your loop's slug and human-readable name. The frontmatter `name` field must be a single valid slug — no curly braces.

# Discovery Skill: {Business Name}

## When I am triggered

- User calls /{name} or scheduled trigger
- User says "run {name} discovery"

## Data sources

- Source 1: {description}
- Source 2: {description}

## What I do

1. Scan data sources and identify items worth processing today
2. Output `state/discovery-{YYYY-MM-DD}.md`:

```markdown
# {Business Name} Discovery · {Date}

## Today's Items
1. {Item 1}
2. {Item 2}

## Filtered Out
- {Item}: {reason}
```

3. Append to log.md: `[YYYY-MM-DD HH:mm] task=discovery-{name} | found=N items`

## What I must never do

- Execute generation actions (writing copy, modifying files) — that is the generator's job
- Modify any existing files
- Send anything externally

## After completion

Proactively prompt: "Found N items. Invoke generator-{name} to begin processing?"
