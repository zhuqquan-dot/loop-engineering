# docs/

This directory holds the **public-facing narrative** of the Loop Engineering methodology.

## Purpose

`docs/` is for human readers — people browsing the GitHub repository who want to understand the method before adopting it.

It is intentionally separate from [`references/`](../references/), which contains the **operating rules** that an AI agent loads at runtime.

## Layer boundary

| Question | Where it lives |
|---|---|
| Why does this method exist? | [`docs/philosophy.md`](./philosophy.md) |
| How do I get started in 6 steps? | [`docs/quickstart.md`](./quickstart.md) |
| How do I decide L-READ vs L-DRAFT vs L-ACT? | [`docs/grading.md`](./grading.md) |
| Why is the evaluator non-negotiable? | [`docs/evaluator.md`](./evaluator.md) |
| Why files instead of chat memory? | [`docs/memory.md`](./memory.md) |
| What are the most common mistakes? | [`docs/anti-patterns.md`](./anti-patterns.md) |
| Quick yes/no questions | [`docs/faq.md`](./faq.md) |
| Phase-by-phase implementation rules | [`references/`](../references/) |
| Anti-pattern catalog with diagnostics and fixes | [`references/05-anti-patterns.md`](../references/05-anti-patterns.md) |
| Hot/warm/cold rolling specification | [`references/08-hot-warm-cold.md`](../references/08-hot-warm-cold.md) |

## Rule of thumb

- If a file teaches a human **what the method is**, it belongs in `docs/`.
- If a file tells an agent **how to apply the method step by step**, it belongs in `references/`.
- If two files cover the same topic, the one in `docs/` is a summary and the one in `references/` is the source of truth.

## Reading order

If you are completely new, read in this order:

1. [`docs/philosophy.md`](./philosophy.md)
2. [`docs/quickstart.md`](./quickstart.md)
3. [`docs/grading.md`](./grading.md)
4. [`docs/evaluator.md`](./evaluator.md)
5. [`docs/memory.md`](./memory.md)
6. [`docs/anti-patterns.md`](./anti-patterns.md)
7. [`docs/faq.md`](./faq.md)

Then move to [`SKILL.md`](../SKILL.md) and the [`references/`](../references/) directory when you are ready to implement.
