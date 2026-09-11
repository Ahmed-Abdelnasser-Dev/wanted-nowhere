# Copilot instructions

This file is Copilot-specific. Everything about the game itself (design pillars, layout, GDScript
conventions, verification, harness setup) lives in `AGENTS.md` at the repo root; read that first.
Copilot does not automatically read `AGENTS.md`, so the rules that matter most are restated here.

## Writing style

No em dashes (`—`) or en dashes used as sentence connectors (`–`) anywhere: markdown docs, code
comments, or any text the player sees. Use a comma, semicolon, colon, parentheses, or a full stop
instead, whichever fits the sentence. This applies whether the change comes from Copilot, Claude
Code, or Antigravity.

Untouched by this rule: hyphens inside compound words (`top-down`, `3-hit combo`, `rogue-like`),
markdown bullet markers (`- item`), kebab-case filenames, CLI flags (`--headless`), and GDScript
operators or literals.

## Localization

English and Arabic are supported from the first UI element, not bolted on later. Every user-facing
string goes through a translation key, never a literal, and UI layout must tolerate right-to-left
mirroring. See `AGENTS.md` → "Localization" for the pipeline details.

## Everything else

Rendering contract, project layout, GDScript conventions, verification loop, and the local MCP/skills
harness setup are all in `AGENTS.md`. Read that file before making non-trivial changes.
