# Contributing to Loop Engineering

Thanks for your interest in improving Loop Engineering. This project is a methodology repository, not a runtime, so contributions tend to be one of three kinds.

## What this project accepts

1. **Adapter contributions** — mapping the core methodology onto a new agent environment (e.g. a new IDE agent, a new automation platform).
2. **Reference improvements** — clarifications, edge cases, or anti-patterns that the existing references miss.
3. **Documentation polish** — fixing wording, broken links, or making the public docs friendlier.

## What this project does not accept

- Pull requests that weaken the core methodology to make it easier (the methodology is intentionally complete).
- Pull requests that remove the human gate, the evaluator separation, or the auto-downgrade mechanism.
- Vendor advertising disguised as adapter contributions.
- Changes that hard-code one platform's behavior into the core `SKILL.md` or `references/`.

## Repository layout (where things belong)

| Layer | Location | Purpose |
|---|---|---|
| Agent entry point | [`SKILL.md`](./SKILL.md) | The single file an AI agent reads to understand the method |
| Public narrative | [`README.md`](./README.md), [`docs/`](./docs/) | Human-readable explanation, marketing-free |
| Methodology core | [`references/`](./references/) | The actual rules and edge cases |
| Reusable starters | [`templates/`](./templates/) | Copy-and-adapt skills and state files |
| Platform mappings | [`adapters/`](./adapters/) | One file per agent environment |
| Concrete cases | [`examples/`](./examples/) | End-to-end examples that show the method in action |

When in doubt: platform-specific text goes in `adapters/`, methodology text goes in `references/`, public-facing prose goes in `docs/`.

## Adding a new adapter

1. Copy [`adapters/cursor.md`](./adapters/cursor.md) as a baseline (the most minimal adapter).
2. Rename it to `adapters/<your-agent>.md`.
3. Fill in the **Concept mapping** table — every row from the baseline must be answered, even if the answer is "not supported".
4. List **Key differences** honestly. If the platform cannot do `/goal`-style maker-checker, say so.
5. Add a **Quick start** section. The commands must be executable from the repository root and must not reference any version-suffixed directory name.
6. Add **Limitations and notes** so users know when to fall back to manual control.
7. Update [`adapters/README.md`](./adapters/README.md) to list the new adapter.

## Pull request checklist

Before opening a PR, please confirm:

- [ ] The change does not remove or weaken the human gate, evaluator separation, or auto-downgrade.
- [ ] All new cross-file references use Markdown links, not bare paths.
- [ ] No new file hard-codes a single vendor name into the core methodology.
- [ ] If you added a new adapter, the install commands run from the repository root.
- [ ] If you added a new SKILL template, frontmatter has `name`, `description`, `author`, and `version`.
- [ ] [`CHANGELOG.md`](./CHANGELOG.md) has a new entry under an `Unreleased` or version section.

## Discussion before code

For anything beyond a typo fix, please open an issue first. Use the issue templates so the discussion lands in the right channel:

- [Bug report](./.github/ISSUE_TEMPLATE/bug_report.md) — something is factually wrong or broken.
- [Adapter request](./.github/ISSUE_TEMPLATE/adapter_request.md) — you want a new agent environment supported.
- [Methodology question](./.github/ISSUE_TEMPLATE/methodology_question.md) — you think a rule needs adjustment.

For security concerns, see [`SECURITY.md`](./SECURITY.md). All participation is governed by [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md).

## License

By contributing, you agree that your contribution will be licensed under the [MIT License](./LICENSE).
