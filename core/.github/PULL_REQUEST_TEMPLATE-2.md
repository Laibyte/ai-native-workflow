## Description

(AI: Replace this section with a high-level summary of the change, its purpose, and how to test it.)

## Linked Issue

- Closes #

## AI "Definition of Done" Checklist

> (AI Agent: You MUST verify all these points are true before submitting for review.)

- [ ] Tests Passed: All local tests (vitest run, pytest) passed via the automated validation hook.
- [ ] CI Passed: All GitHub Actions (lint, test, build) are green.
- [ ] Self-Reviewed: A 14-point AI self-review has been completed and attached as a comment to this PR.
- [ ] Context-Aware: All changes align with the requirements in @docs/PROJECT_SPEC.md and @docs/ARCHITECTURE.md.
- [ ] Documentation Updated: README.md, JSDoc, or docstrings have been updated to reflect these changes.
- [ ] Memory Updated: Any new architectural decisions or patterns introduced in this PR have been added to @docs/MEMORY_BANK.md.

---

## Human Reviewer Checklist

**This review focuses on INTENT and LOGIC, not style (which is automated).**

- [ ] **Intent Validation:** Does this code fully address the requirements of the linked Linear issue?
- [ ] **Architectural Fit:** Does this change align with the patterns in `AGENTS.md` / `docs/ARCHITECTURE.md`?
- [ ] **Logical Soundness:** Are there any obvious logic errors, race conditions, or flawed assumptions?
- [ ] **Edge Case Handling:** Did the AI correctly handle null inputs, empty arrays, auth failures, and other edge cases?
- [ ] **Test Validity:** Are the AI-generated tests meaningful? Do they test *failure* cases and not just the "happy path"?
- [ ] **No Hallucinations:** Does the code import or call any non-existent functions or deprecated APIs?

## AI Assistance Disclosure

Check one:

- [ ] Primary Author: Human
- [ ] Pair-Programmed (AI-Assisted): Human-led, AI-assisted.
- [ ] AI-Generated: AI-led (e.g., Background Agent), Human-reviewed.