# 01 · Clarify: 3 Hard Gates + 2 Soft Prompts

Every loop design must pass these 5 checks. The first 3 are hard gates. The last 2 are soft prompts. Only loops that pass all 3 hard gates may proceed to the build phase.

## Why 3+2

A process that is too heavy will make people skip the entire process — including the parts they should not skip. When a lightweight task like "check 3 competitors daily" demands answering 5 full questions, users will not answer them honestly. They will close the process.

So the truly non-skippable questions become hard gates. The "you have a right to choose" questions become warnings, recorded so that six months later you can trace back to the decision you made.

---

## Hard Gates (must all pass)

### H1: Frequency — How many times in the last 30 days?

**Why this is a hard gate**: a one-off task does not justify a loop. The cost of a single conversation is far lower than the cost of building and maintaining a loop.

| Frequency | Recommendation |
|---|---|
| ≥ 20 times/month | Strong loop candidate |
| 5–19 times/month | Weak candidate — try a quick command for a month first |
| < 5 times/month | Do not loop |

**Examples**:
- "Scan 5 competitor accounts every morning" — 30 times in 30 days → PASS
- "Write one competitive analysis per month" — 1 time in 30 days → REJECT. Use a quick command.

### H2: Risk — If the AI gets it wrong, is the damage reversible? Who catches it?

**Why this is a hard gate**: irreversible output generated in bulk by AI will take you longer to clean up than it saved you. That debt is incurred the moment you build the loop.

**Examples**:
- "Daily intelligence brief stored locally, no one sees it if it is wrong" → very low risk
- "AI picks inventory data, but only I can see it" → reversible (data isolation), pass with monitoring recommended
- "AI automatically sends quotes to customers" → if sent, irreversible → REJECT full automation

### H3: External action — Does it involve sending, publishing, merging, or calling external APIs?

**Why this is a hard gate**: this is the most dangerous subset of irreversibility — it automatically crosses your control boundary.

**Iron rule**: even if H3 passes (you agree to add a gate), **the final step must never be executed automatically by AI**.

**Correct approach**: AI drafts → enters review inbox → you confirm → AI executes.

---

## Soft Prompts (warnings only, do not block)

### S1: Completion definition — List 3 observable success criteria

**Why only a soft prompt**: many people cannot define "what done looks like" the first time they build a loop. They need to run it to find out. Blocking here would stop all exploration.

**But you have been warned**: without criteria, there is no basis for evaluation. You also lose the right to complain that the loop's output is "not good enough." When quality starts to degrade three months later, you will be the only person who does not know which standard to tighten.

### S2: Review willingness — Commit to 5 minutes per week reviewing output

**Why only a soft prompt**: if this question becomes a gate, users will learn what to say to pass it. The only way to prevent false compliance is to stop treating it as a test.

**But you have been warned**: if you truly stop reviewing from week 3 onward, the health of your loop will degrade silently. Not because you are lazy — because the loop has no internal mechanism to detect "the user has left." By the time you need to look at it again, you will be a stranger to your own project.

**Consequence of skipping**: recorded. You accept the risk of decay. Loops with no human review for a continuous month will trigger automatic downgrade (see Phase 3).

---

## Output formats

### All gates passed

```text
### Clarification PASSED
H1: 30 days, N times → PASS
H2: risk level = [low/medium/high], fallback person = [you/other/none]
H3: external action = [none / present, human gate position confirmed]
S1: completion definition = [provided / skipped (recorded)]
S2: review willingness = [committed / skipped (recorded)]

### Recommended level
[L-READ / L-DRAFT / L-ACT]

Proceed to Phase 2: Build.
```

### Hard gate failed

```text
### Loop not recommended
Failed: [H1/H2/H3]

### Alternatives
- Quick command /xxx (save the prompt but trigger manually)
- Single conversations (ask directly each time)
- Run manually for 30 days, then reassess
```

### Gates passed but warnings skipped

```text
### Clarification PASSED (with skipped warnings)
[Same as above, but mark which S items were skipped]

### Suggestion
Return to this step after 30 days and fill in what was skipped.
```
