# Anti-Patterns

This is a public summary of the most dangerous mistakes in loop design. The full list with detailed remediation guidance is in [`references/05-anti-patterns.md`](../references/05-anti-patterns.md).

## 1. No independent evaluator (L-DRAFT and above)

A loop where the generator also serves as its own reviewer is not a loop. It is self-narration.

The same agent that produced the output cannot evaluate it. It sees its own reasoning, not the result. It will find its own work convincing.

**Fix**: evaluator must be a separate agent or separate task.

## 2. Generator and evaluator are the same agent (same conversation self-review)

When the generator finishes and immediately reviews its own work in the same context, it is not evaluating — it is describing its own thought process.

**Fix**: evaluator must be structurally separate. Different models help, but the core fix is a different agent.

## 3. Fully automated external action

Generating and automatically sending, publishing, or merging is the fastest self-destructive pattern in agent workflows.

**Fix**: external action must have a human gate. AI drafts, human confirms, AI executes.

## 4. State lives in chat memory

If state is stored in conversation history, it disappears when the session ends. Each run starts from amnesia.

**Fix**: state must be written to files.

## 5. Low-frequency task forced into a loop

Tasks that happen less than 5 times per 30 days cost more to maintain as loops than to handle manually.

**Fix**: use quick commands or single conversations instead.

## 6. Looping a judgment call

Tasks that require full human judgment should never be looped. The method cannot replace decision-making.

**Fix**: AI serves as a thinking partner, not a decision-maker.

## 7. Skipping manual stabilization before scheduling

Jumping directly to automated scheduling without proving the loop works under manual operation is asking for unsupervised errors.

**Fix**: 30 days of manual triggering before any scheduling.

## 8. Disguising a high-risk loop as a low-risk one

Describing an L-ACT task as L-READ or L-DRAFT to avoid required guardrails defeats the entire methodology.

**Fix**: if external action keywords are detected, force upgrade to L-ACT.
