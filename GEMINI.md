# GEMINI.md

Antigravity (`agy`)-specific notes for **Wanted Nowhere**. Everything about the game itself — design
pillars, layout, GDScript conventions, verification, harness setup — lives in `AGENTS.md`; read that
first. This file only covers what's specific to working here as Antigravity.

## What's different from Claude Code

- `agy` does **not** read `CLAUDE.md` or `.claude/` — those are Claude Code-only. This file and
  `AGENTS.md` are the ones that apply here.
- Skills come from `.agents/skills/` (36 curated Godot skills — see `AGENTS.md` for the full list and
  what each covers). Reach for the matching one before writing non-trivial gameplay code.
- The `godot` MCP server is wired through the project's `.mcp.json` (see `AGENTS.md` → Local harness
  setup) — same server, same tool set, as Claude Code uses. If `agy mcp list` doesn't show `godot`,
  the harness setup in `AGENTS.md` hasn't been run locally yet.

Everything else — coordinate systems, held-input persistence, the single-holder port 9090, real time
passing between tool calls — applies the same way it does for Claude Code; see `CLAUDE.md` for the
details even though `agy` won't read that file itself.
