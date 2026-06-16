# 04 · Reuse: Cross-Project Harvesting

## Harvest trigger conditions

**Stability criteria** (all must be met to begin harvesting):

- Continuous 30 days of run records
- Weekly rejection rate stable in 5%–25% range
- No auto-downgrade triggered
- Your subjective assessment: "it is genuinely helping me"

## Harvest deliverables

```
examples/{project-name}/
├── README.md              # 30-day data + business context
├── lessons.md             # Things that went wrong
├── prompts.md             # Key prompt extracts (most effective generator and evaluator phrasing)
└── skills-template/       # De-business-ified skill templates
    ├── discovery.md
    ├── generator.md
    └── evaluator.md
```

### README.md template

```markdown
# Loop Case: {business name}

## 30-day data
- Trigger count: _
- PASS rate: _%
- Rejection rate: _%
- Time saved: _ minutes/day

## Business context
- Applicable role:
- Pain point:
- Unsuitable scenarios:

## Model selection
- Generator: _
- Evaluator: _
- Rationale:

## Scheduling
- Current phase: Lv1 / Lv2 / Lv3
- Trigger frequency:
```

### lessons.md template

```markdown
# Things that went wrong

## Pitfall 1: [one sentence]
- Symptom:
- Cause:
- Fix:
- Prevention for next time:
```

### skills-template/ — removing business specifics

Copy the production skill, replace all business-specific content with placeholders:

- `{business name}` — project name
- `{data source 1}`, `{data source 2}` — information sources
- `{criterion 1}` etc. — completion definitions
- Keep the generic framework (instruction structure, evaluation logic, output format)

## Cross-project reuse process

1. Search `examples/`: is there a similar type of loop?
2. If yes → fork from `skills-template/` → replace placeholders → re-run the 3 hard gates → build
3. If no → go through the full four phases, harvest after stability

> Iron rule: even when forking, re-run clarification. The new project may not deserve a loop.

## Upgrading to global skill

When a loop type has been reused in at least 3 projects → move to global skills directory → mark "cross-project verified."

## Anti-patterns

- Harvesting after only 7 days — not enough data
- Copying only the prompt, not writing lessons — same mistakes next time
- Not updating examples — expired by the time you reuse them 6 months later

Review examples quarterly. Mark expired cases as [DEPRECATED].
