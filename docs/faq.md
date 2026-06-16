# FAQ

## Is Loop Engineering just prompt engineering with a different name?

No. Prompt engineering is about how you phrase a single request. Loop Engineering is about how you structure repeated work across multiple runs, with state, separation, and guardrails.

A good prompt does not prevent a generator from self-reviewing. It does not compress old logs. It does not gate external actions. Those are structural problems, not phrasing problems.

## Do I need Loop Engineering for every task?

No. The methodology itself requires that you reject tasks that do not repeat enough, tasks where the cost of process exceeds the risk of error, and tasks that require human judgment that cannot be delegated.

The first hard gate (H1) asks whether the task has occurred at least 5 times in the last 30 days. If it has not, the methodology tells you to stop.

## Can I use this without being a developer?

Yes. The methodology does not require writing code. It requires understanding the structure: what level a task is, whether it needs a separate evaluator, where the human gates are, and how state is managed.

If you are using an agent in a non-technical role, the grading model and the evaluator concept are still directly applicable.

## Does this work on all agent platforms?

The core methodology is platform-independent. The four platform adapters (Claude Code, Codex, Cursor, Trae) explain how to map the methodology onto each environment. You can write additional adapters for other platforms by following the same pattern.

## Why do I need an evaluator? Can the same model just check its own work?

No. A generator checking its own output is reviewing its own reasoning, not the result. It sees the path that led to each decision and cannot read the output as a fresh reader would.

An independent evaluator starts cold. It has no stake in the generator's choices. That structural distance is the entire value.

## What if my platform does not support multiple models?

That is fine. The non-negotiable requirement is structural separation — different agents or different tasks. Using a different model is a recommended upgrade but not required.

## How is this different from just using agent automations directly?

Most agent platforms offer scheduling features. What they do not offer is:

- A grading model that matches process intensity to risk
- A requirement that generation and evaluation be separated
- A human gate for external actions
- State compression to prevent context decay
- Guardrails that detect abandonment

Loop Engineering is the operating discipline you add on top of the scheduling feature.

## What happens if I stop maintaining a loop?

The methodology has a built-in self-destruct mechanism: if a weekly audit is not run for 4 consecutive weeks, the loop automatically downgrades. L-ACT becomes L-DRAFT. L-DRAFT becomes L-READ. It does not continue running unattended at full power.

## Can multiple people share a loop?

The methodology includes a multi-user governance reference ([`references/06-multi-user.md`](../references/06-multi-user.md)) with conventions for shared rules, inbox deduplication, and cross-loop dependencies. Multi-user use is treated as optional and secondary to the single-user design.

## Is this production-grade?

The methodology is designed to be conservative enough for real use. It assumes the user wants structure, not magic. It makes explicit claims about what it can and cannot do. It does not promise to eliminate all errors — it promises to make them visible and manageable.

Whether that qualifies as production-grade depends on your definition. If production-grade means "no errors ever," this is not that. If it means "errors are caught, bounded, and traceable," then yes.
