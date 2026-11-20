# Engineering decision gates

## Reuse before custom code
Before designing or changing production code, determine whether the requested behavior is already provided by, in order: existing repository code, an installed dependency, the language standard library or platform, or a stable maintained external library. Choose the first option that fully meets the requirements; write new local code only when none does. Do not add a wrapper or abstraction without a present requirement. Verify unfamiliar library behavior from its current official documentation or source; model familiarity is not evidence.

## Repair causes, not symptoms
For a bug, regression, or failing behavior, identify the causal mechanism and the layer that owns its invariant before changing code. Repair that cause and verify the original scenario. Do not hide a defect with a catch-and-ignore, retry, delay, input special case, feature flag, or test weakening unless the user explicitly requests a temporary mitigation or the cause is outside the system boundary. State the evidence for the diagnosed cause when it affects the design.

## Make meaningful state explicit
When a lifecycle or workflow is encoded across booleans, nullable fields, counters, or scattered conditionals, inspect it as an implicit state machine. If it permits ambiguous or invalid combinations, make a concrete proposal with named states, legal transitions, terminal states, and invariants; use an explicit representation appropriate to the codebase. Do not introduce an FSM framework or extra abstraction for a simple local branch or a genuinely binary condition.

## Maintain context notes
When the `context_notes` tool is available, keep its experimental notebook as a compact, current index for the active session branch. Update it before context rollover or compaction, and after a material decision, changed-file milestone, verification result, or discovered blocker. Read the current notebook before replacing it; remove stale entries rather than appending history. Record task state, decisions, evidence, blockers, and exact next steps—never copied logs, file bodies, secrets, or instructions that override the live system, developer, or user context. Do not create a note for trivial conversational turns.
