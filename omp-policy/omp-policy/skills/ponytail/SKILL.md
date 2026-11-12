---
name: ponytail
description: >
  Mandatory minimal-code decision gate for any task that implements, modifies,
  refactors, or designs production code. Before proposing or writing code,
  determine whether the requested outcome is already satisfied, can use existing
  repository code, an installed dependency, the standard library, or a native
  platform capability. Preserve required behavior, contracts, validation, error
  handling, security, accessibility, performance, observability, and verification.
  Use automatically for every code-change task; less code is never a reason to
  weaken requirements.
---

# Ponytail: minimal correct change

## Objective

Deliver the smallest correct change that fulfils the user's request. Fewer lines
are an outcome, not a requirement. Correctness, explicit acceptance criteria, and
maintainability take priority over brevity.

## Mandatory decision gate

Before proposing or changing code, inspect the relevant repository context. Then
use the first option that fulfils the request completely:

1. **No code change** — the requested behavior already exists or configuration can
   enable it.
2. **Existing repository capability** — reuse or compose an established API,
   component, helper, or pattern.
3. **Installed dependency** — use the documented capability already present in the
   project.
4. **Standard library or native platform capability** — prefer a built-in API over
   a wrapper or replacement.
5. **New code** — add only behavior that the preceding options cannot provide.

Do not claim that an option is unavailable without checking the relevant source,
dependency metadata, or official API documentation.

## Non-negotiable constraints

- Never reduce the requested behavior merely to make a diff shorter.
- Preserve public contracts and all required validation, error handling, security,
  accessibility, performance characteristics, observability, and diagnostics.
- Do not add a dependency when an existing dependency, platform API, or standard
  library fulfils the requirement.
- Do not create wrappers, abstractions, configuration, or extension points without
  a concrete present requirement.
- When replacing superseded code, migrate every affected caller and remove the
  obsolete implementation rather than leaving a compatibility path by default.
- Follow the repository's established conventions; do not introduce a second
  pattern for the same responsibility.

## Applying the decision

State the selected option and the evidence only when it affects the design,
trade-off, or user-facing behavior. Do not add `ponytail` comments or other
process markers to production code.

If new code is necessary, make the change direct and local. Prefer a native
primitive or an existing project interface over a new façade. Remove code made
obsolete by the chosen implementation.

## Verification

Verify the resulting behavior on the changed path. The verification must cover
the requirements retained by the decision gate, not only that the shorter code
runs. If the smallest option cannot preserve a required property, choose the
next option that can.
