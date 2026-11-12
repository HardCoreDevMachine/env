---
name: improve-codebase-architecture
description: >
  Explicit user-invoked architecture review. Use only when the user writes
  /improve-codebase-architecture or expressly asks to scan, improve, or review
  codebase architecture. Find evidence-backed deepening opportunities in a named
  area or recent hot spots. Report directly in the session by default; write a
  Markdown report only when the user explicitly requests one. Never generate
  HTML and never change production code during the review.
---

# Improve Codebase Architecture

## Contract

This is a read-only architecture review until the user selects a candidate and
confirms a shared understanding. Its purpose is to find refactors that increase
**depth**, **leverage**, **locality**, and testability—not to enumerate style
nits or prescribe a rewrite.

Report directly in the session unless the user explicitly asks for a Markdown
file. Never generate HTML, use browser opening commands, or load web assets.

## Scope before scanning

1. If the user names a module, subsystem, file, or pain point, use it as the
   scope.
2. Otherwise inspect a meaningful span of recent change history and use repeated
   paths as the initial hot spots. If history gives no signal, state that and
   select the smallest representative area supported by repository evidence.
3. Read a project glossary and relevant ADRs when they exist. They constrain the
   review; do not create or modify them during this mode.
4. Establish facts from the repository, language tooling, and documentation.
   Do not ask the user to locate facts that can be discovered directly.

## What to look for

Use the `codebase-design` vocabulary precisely:

- A **module** is deep when callers receive substantial behaviour through a
  small **interface**.
- A **seam** is where behaviour can change without editing at that location.
- **Leverage** is the repeated value a deep module gives callers; **locality** is
  the concentration of change, knowledge, bugs, and verification.
- An **adapter** deserves a seam only when variation is real: one adapter is a
  hypothetical seam; two make it real.

Look for evidence of friction, such as callers repeating the same coordination,
a module that exposes implementation detail, changes scattered across coupled
files, tests that must cross a module's interface, or an adapter with no actual
variation. Apply the deletion test: if deleting the suspected module merely
moves its complexity into every caller, it earns its keep; if complexity
vanishes, it is shallow.

Do not recommend a candidate based only on line count, file count, naming taste,
or an imagined future integration. Do not offer interfaces yet.

## Session report

Start with **Scope and evidence**: the examined area, repository facts, and any
important constraint from an ADR or glossary.

Then give at most five actionable candidates. For each candidate, use this form:

```markdown
### <N>. <candidate name> — <Strong | Worth exploring | Speculative>

**Files:** <relevant modules>
**Evidence:** <specific repeated change, coupling, caller duplication, or test friction>
**Problem:** <why the current module/interface is shallow or the seam leaks>
**Deepening:** <what behaviour would move behind which interface or seam>
**Payoff:** <expected leverage, locality, and testing improvement>
**Risk:** <what could make this wrong, including ADR conflict>
```

Finish with **Top recommendation** only when evidence supports one. Explain why
it outranks the alternatives. If no candidate clears that bar, say so plainly.
Then ask which numbered candidate, if any, the user wants to explore.

## Optional Markdown report

Write a Markdown report only after an explicit user request. If the user gives a
path, use it. If they ask for a file without a path, write
`architecture-review.md` in the project root. Its content must be the same
session report, not a second format or an expanded speculative audit.

## After selection

When the user picks a candidate, continue as a decision interview before
proposing an interface or editing code:

1. Build a decision tree of constraints, seam placement, behaviour to hide,
   callers to migrate, and verification requirements.
2. Ask only decisions whose prerequisites are settled. Ask all independent
   material decisions in a round; every question includes a recommendation the
   user can accept with “yes”.
3. Investigate facts yourself. Do not silently choose a business decision.
4. Summarize the shared understanding and wait for confirmation before planning
   or implementation.
