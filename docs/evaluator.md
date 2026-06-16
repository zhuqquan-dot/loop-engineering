# The Evaluator

The evaluator is the most important component in any loop above L-READ. It is also the one people most often try to skip. This document explains why skipping it is dangerous and how to build one correctly.

## What an evaluator actually does

An evaluator is an independent agent or independent task whose only job is to say "no."

It receives the generator's output, applies a checklist, and produces exactly one of three verdicts:

- **PASS**: the output is acceptable as-is
- **FAIL**: the output is not acceptable, with specific reasons
- **HUMAN**: the output needs a person to decide

## Why independence matters

A generator evaluating its own output is not doing evaluation. It is doing self-narration.

The generator already knows why it wrote what it wrote. It sees the reasoning chain that led to each sentence, not the sentences as a reader would read them. When it reviews its own work, it reviews the process, not the result.

An independent evaluator starts cold. It sees only the output, not the reasoning. It has no investment in the decisions the generator made. That structural distance is the entire value.

## Independence is structural, not model-based

The non-negotiable requirement is that the generator and evaluator must be separate agents or separate tasks.

Using a different model for the evaluator is a useful upgrade — a model from a different family or vendor is more likely to notice different issues. But it is not required. The structural separation alone provides the core value: the evaluator did not participate in generating the output, so it has no momentum to defend any particular decision.

## Evaluator calibration

Every evaluator must include a calibration block. This is not optional.

```yaml
## EVALUATOR CALIBRATION (DO NOT MODIFY WITHOUT RE-AUDIT)
calibration_date: YYYY-MM-DD
calibration_standard: "Assume the output is wrong unless proven acceptable"
rejection_rate_target: 10%-25%
last_audit_date: YYYY-MM-DD
strictness_level: high
```

The calibration block serves two purposes:
1. It forces you to acknowledge the evaluator's stance explicitly
2. It enables automatic reset when the evaluator becomes too lenient

## Why a rejection rate target

An evaluator that passes everything has stopped being an evaluator. It has become a rubber stamp.

The target range (10%-25%) is intentionally not zero. If the rejection rate is 0%, it means either:
- The generator is flawless, or
- The evaluator is not actually checking

In practice, the second explanation is far more likely.

When the rejection rate falls below 5% for 4 consecutive weeks, the evaluator's strictness level automatically resets to `high`. This prevents silent drift toward leniency.

## What an evaluator must never produce

Vague verdicts are worse than no verdicts. An evaluator must never output:

- "Overall good, minor suggestions only"
- "Basically meets requirements"
- "Looks fine to me"
- Any output that does not contain PASS, FAIL, or HUMAN as an explicit conclusion

Every judgment must reference a specific standard and a specific piece of evidence. If the evaluator cannot point to the exact line, paragraph, or data point that violated a standard, it has not actually evaluated anything.

## Platform-specific evaluator implementation

Different platforms support evaluator independence in different ways:

- **Claude Code**: define evaluator as a subagent in `.claude/agents/`, optionally with a different model
- **Codex**: define evaluator as a subagent in `.codex/agents/` TOML, optionally with a different model
- **Cursor**: open a separate conversation window for the evaluator
- **Trae**: create a separate task in a new conversation window

The platform adapter files in [`adapters/`](../adapters/) contain the specific implementation details for each environment.

## The evaluator is not a suggestion

For L-DRAFT and L-ACT loops, an evaluator is a hard requirement. A loop without one will not be approved at the build stage.

If your platform genuinely cannot support a separate evaluator process, the minimum acceptable alternative is a human checklist applied manually to the output. But this should be treated as a temporary workaround, not a permanent solution.
