---
name: grill-me
description: >
  Explicit, user-invoked requirements and design interview. Use only when the
  user writes /grill-me or expressly asks to be grilled, interrogated, or
  stress-tested about a plan, design, feature, or decision. Resolve the design
  tree through structured rounds before planning or implementation. Never invoke
  automatically for ordinary coding or planning requests.
---

# Grill Me: resolve the design before acting

## Contract

Once explicitly invoked, remain in interview mode until the user ends it or
confirms a shared understanding. Do not implement, edit files, create tickets,
or treat an unconfirmed recommendation as a decision.

The goal is a complete, shared understanding of the requested work. Be exacting,
not adversarial: expose material choices, constraints, dependencies, edge cases,
and acceptance criteria that would otherwise be silently assumed.

## Build a decision tree

1. Start from the user's stated goal and identify material decisions required to
   fulfil it.
2. For every decision, record the prerequisite decisions and facts it depends on.
3. A decision is on the **frontier** when its prerequisites are settled. Only
   frontier decisions may be asked in the current round.
4. Rebuild the frontier after every user response. A choice that depends on an
   unanswered choice belongs in a later round.
5. Finish only when no material decisions remain unresolved.

Facts are the agent's responsibility. Inspect the repository, documentation,
tools, and available evidence instead of asking the user for information that
can be discovered. Ask the user only for decisions, preferences, priorities, or
business knowledge they alone can provide. If fact-finding is still in progress,
continue with independent frontier decisions and defer only the dependent ones.

## Run interview rounds

Ask every currently independent, material frontier decision in one round. Number
the questions. Every item MUST state the decision's consequence, concrete options
when helpful, and one recommended answer that the user can accept with “yes”.
A bare list of questions is invalid.

Render every item in this exact form:

```markdown
❓ **Q1 — <decision>**: <what must be decided, why it changes the outcome, and concise options>

➡️ **Recommendation:** <one option and the evidence or trade-off behind it>. Reply “yes” to accept.

---
```

Keep a question out of the round if its answer relies on another open question in
that round. Do not invent an answer to keep the interview moving. Do not repeat
settled decisions unless new evidence invalidates them.

After asking a round, wait for the user's answers. Interpret concise answers by
question number. If an answer is ambiguous, ask the smallest clarifying question
needed to settle that branch.

## Close the interview

When the frontier is empty, present a compact **Shared understanding** record:

- goal and non-goals;
- decisions made and their rationale;
- discovered constraints and relevant facts;
- acceptance criteria and verification expectations;
- explicitly deferred work, if any.

Then ask the user to confirm that record. Do not begin planning or implementation
until they confirm or explicitly direct the next action. If they stop the grill
before completion, identify the still-open decisions rather than silently making
them.
