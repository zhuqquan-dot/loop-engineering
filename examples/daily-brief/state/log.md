# daily-brief · log.md (hot state)

> Append-only operational log. One line per loop step. Compress to `weekly-summary.md` every Monday. Rotate to `archive/` quarterly.

## Schema

`[YYYY-MM-DD HH:mm] task={skill} | {key=value pairs}`

## Recent entries

[2026-06-14 08:32] task=discovery-daily-brief | found=12 | filtered=4 | sources_unreachable=0 | confidence=high
[2026-06-14 08:41] task=generator-daily-brief | draft=state/draft-daily-brief-2026-06-14.md | categories=4 | insights=3
[2026-06-14 08:43] task=evaluator-daily-brief | verdict=PASS | rejected_criteria=0 | published=state/published/daily-brief-2026-06-14.md

[2026-06-15 08:30] task=discovery-daily-brief | found=8 | filtered=2 | sources_unreachable=1 | confidence=medium
[2026-06-15 08:38] task=generator-daily-brief | draft=state/draft-daily-brief-2026-06-15.md | categories=4 | insights=3
[2026-06-15 08:41] task=evaluator-daily-brief | verdict=FAIL | rejected_criteria=d | reason="insight #2 cited a price change not present in discovery"

[2026-06-16 08:33] task=discovery-daily-brief | found=10 | filtered=3 | sources_unreachable=0 | confidence=high
[2026-06-16 08:42] task=generator-daily-brief | draft=state/draft-daily-brief-2026-06-16.md | categories=4 | insights=3
[2026-06-16 08:45] task=evaluator-daily-brief | verdict=HUMAN | reason="insight #3 recommends pricing response — escalate to human"
