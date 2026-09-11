# CLAUDE.md

Claude Code-specific notes for **Wanted Nowhere**. Everything about the game itself (design pillars,
layout, GDScript conventions, verification, harness setup) lives in `AGENTS.md`; read that first.
This file only covers what's specific to working here as Claude Code.

## Godot MCP tool gotchas

The `godot` MCP server (see `AGENTS.md` → Local harness setup) gives access to `mcp__godot__*` tools.
A few things that aren't obvious from the tool descriptions:

- **Coordinates**: `game_click` and similar take **window** coordinates (1280x720, or whatever the
  actual window is scaled to), not viewport coordinates (640x360); multiply viewport-space
  coordinates by the stretch scale before calling.
- **Held input persists**: `game_key_hold` keeps a key down across `run_project` resets. Always
  release explicitly (`game_key_release`) rather than assuming a reset clears it.
- **Real time passes between tool calls.** Timers, cooldowns, enemy AI, health drains: all keep
  running while you're reading a screenshot or thinking about the next call. For scripted,
  deterministic inspection, zero out time-based drains via `game_eval` before testing, or account for
  the elapsed wall-clock time.
- **Port 9090 is single-holder.** If an editor playtest is already running, `run_project` will fail
  to bind; close it first.
- `validate_script` doesn't need a running game; prefer it for a quick syntax/type check before
  `run_project`.

## Skills

`.agents/skills/` holds 36 curated Godot skills (GDScript conventions, signals, combat/ability
systems, animation, tilemaps, UI, platform/export, etc.; full list in `AGENTS.md`). Reach for the
matching skill before writing non-trivial gameplay code, especially for anything touching signals,
state machines, or the ability system: the landmines they document are easy to hit blind.

## Writing style

See `AGENTS.md` → "Writing style": no em dashes anywhere, docs, code comments, or in-game text.

## Commits

End commit messages with the attribution trailer supplied in this session's system context (varies
by session; check the current conversation rather than hardcoding one here).
