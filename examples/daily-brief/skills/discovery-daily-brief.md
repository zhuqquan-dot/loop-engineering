---
name: discovery-daily-brief
description: Daily competitive intelligence discovery skill. Scans the 5 tracked competitor accounts for new posts, releases, and announcements in the last 24 hours and produces a discovery report. Triggered when the user says "run discovery-daily-brief", "/daily-brief discovery", or on a scheduled morning trigger.
author: zhuquan
version: 2.2
license: MIT
---

# Discovery Skill: Daily Competitive Intelligence

> Replace the source list, the keywords, and the timezone in this file with your own setup before installing.

## When I am triggered

- User says "run discovery-daily-brief" or "/daily-brief discovery"
- Scheduled morning trigger (recommended: 08:30 local time)
- After a previous run failed and the user explicitly retries

## Data sources

Configure these for your own loop. The example uses 5 competitor accounts:

1. Competitor A — official blog RSS / X account
2. Competitor B — product changelog page
3. Competitor C — LinkedIn company page
4. Competitor D — Substack newsletter
5. Competitor E — GitHub releases

The discovery skill **must not** crawl any source that requires login or that the user has not authorized.

## What I do

1. Pull entries from each source published in the last 24 hours (timezone: user-local).
2. De-duplicate on canonical URL.
3. Filter out entries that obviously do not match the watch criteria (sponsorships, generic marketing, repost-only).
4. Write the discovery report to `state/discovery-daily-brief-{YYYY-MM-DD}.md` using the format below.
5. Append one line to `state/log.md`:
   `[YYYY-MM-DD HH:mm] task=discovery-daily-brief | found=N | filtered=M`
6. Prompt the user: `Found N items. Invoke generator-daily-brief to draft the brief?`

## Output format

```markdown
# Daily Brief Discovery · {YYYY-MM-DD}

## Today's items (N)
1. **{Source}** — {title} — {url} — {published_at}
2. ...

## Filtered out (M)
- {Source} — {title} — {reason}

## Notes
- Sources unreachable today: [...]
- Confidence: high / medium / low
```

## What I must never do

- Generate the brief myself — that is the generator's job
- Modify any existing files except `state/log.md` and the new discovery report
- Send anything externally
- Skip the de-duplication step
- Mark "confidence: high" if any source was unreachable

## After completion

Hand off to the user with: `Found N items in M sources. Confidence: {level}. Run "generate daily-brief from {report path}" when ready.`
