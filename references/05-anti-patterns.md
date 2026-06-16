# 05 · Anti-Pattern Catalog

## 1. No independent evaluator (L-DRAFT and above)

**Symptom**: loop flow is "AI generate → land directly," or the generator skill has a "self-review" section.

**Why it is wrong**: the same agent that writes something and then judges it will naturally favor its own work. This is not because the model is not smart — it is because the agent sees its own reasoning chain, not the result as an outsider would.

**Fix**: evaluator must be an independent sub-agent / independent task. Different models are recommended but not required. Independent task separation is the minimum.

---

## 2. Generator and evaluator are the same agent (self-review in the same conversation)

**Symptom**: generator finishes, immediately does "self-review" in the same conversation — or "let me review this with a different prompt."

**Why it is wrong**: structurally sharing the same context — this agent has already seen why it wrote what it wrote. It reviews the reasoning, not the result. **Changing the prompt does not change the perspective. Changing the model is secondary to changing the agent.**

**Fix**: evaluator must be an independent sub-agent / independent task. Different models recommended, but the core fix is "different agent" — the evaluator starts from zero with no investment in the generator's decisions.

---

## 3. Fully automated external action

**Symptom**: "AI drafts + auto-send email / auto-merge / auto-quote"

**Why it is wrong**: there is no faster path to self-inflicted damage. The moment it is sent, it is irreversible.

**Fix**: the final step must be human. AI drafts → enters review → you confirm → AI executes.

---

## 4. State dependent on conversation memory

**Symptom**: "the plan we discussed last time", "continue from last time" — relies on conversation window, no persistent files.

**Why it is wrong**: close the conversation = total amnesia. The loop wakes up every day with no memory.

**Fix**: mandatory `state/log.md`.

---

## 5. Low-frequency task forced into a loop

**Symptom**: "monthly campaign analysis, let the loop handle it"

**Why it is wrong**: build and maintenance cost exceeds benefit.

**Fix**: under 5 occurrences in 30 days → use quick command or single conversation.

---

## 6. Looping a judgment task

**Symptom**: "let the loop evaluate whether this customer is worth pursuing"

**Why it is wrong**: judgment requires your full discernment. Looping it = outsourcing your judgment.

**Fix**: AI as thinking partner, you as decision-maker.

---

## 7. Skipping Lv1 manual stabilization

**Symptom**: connecting to scheduled tasks or CI/CD on day 1

**Why it is wrong**: run it manually for a month to confirm it is stable — and to confirm you still care.

**Fix**: mandatory 30 days of manual triggering.

---

## 8. Disguising L-ACT as L-READ

**Symptom**: description says "just take a look for me," but it actually calls an API to send data.

**Why it is wrong**: deliberate downgrade to avoid safeguards = all guardrails disabled.

**Fix**: upon detecting external action keywords → force upgrade to L-ACT.

---

## 9. Forking a template without re-running clarification

**Symptom**: forked a template from examples, replaced placeholders, deployed immediately.

**Why it is wrong**: the new project's business context is different. What passed H2 last time may not pass this time.

**Fix**: even when forking, must re-run the 3 hard gates.

---

## 10. State files never rolled

**Symptom**: log.md has 900 lines, agent reads the entire file every run.

**Why it is wrong**: context is swallowed by historical data. Agent's thinking space erodes.

**Fix**: mandatory weekly rolling and archiving.

---

## 11. Running without harvesting

**Symptom**: ran a good loop but never recorded it in examples.

**Why it is wrong**: next project starts from zero.

**Fix**: after 30 days stable, harvest is required.

---

## Quick diagnostic scripts

```text
User: "Build me a loop to auto-send customer follow-ups"
Skill: "External action detected. I can design it to generate drafts into a review inbox, but the final send must be manual. Continue?"

User: "No evaluator needed, I trust the generator"
Skill: "Rejected. L-DRAFT level requires an independent evaluator. Generate evaluator template now?"

User: "Just check what competitors posted, summarize one line daily"
Skill: "Recommend L-READ. One skill + one log file. Proceed?"
```
