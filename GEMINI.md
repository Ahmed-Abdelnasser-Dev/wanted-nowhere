# GEMINI.md

Antigravity (`agy`)-specific notes for **Wanted Nowhere**. Everything about the game itself (design
pillars, layout, GDScript conventions, verification, harness setup) lives in `AGENTS.md`; read that
first. This file only covers what's specific to working here as Antigravity.

## What's different from Claude Code

- `agy` does **not** read `CLAUDE.md` or `.claude/`; those are Claude Code-only. This file and
  `AGENTS.md` are the ones that apply here.
- Skills come from `.agents/skills/` (36 curated Godot skills; see `AGENTS.md` for the full list and
  what each covers). Reach for the matching one before writing non-trivial gameplay code.
- The `godot` MCP server is wired through the project's `.mcp.json` (see `AGENTS.md` → Local harness
  setup): same server, same tool set, as Claude Code uses.
- Writing style rule applies here too: see `AGENTS.md` → "Writing style". No em dashes anywhere.

## Registering this repo as a workspace

Unlike Claude Code, `agy` does **not** auto-detect the current directory as a project: running
`agy` from inside this repo with no flags gives you zero project context (no `AGENTS.md`, no
`.agents/skills`, no `.mcp.json`). You have to register it once:

- **CLI**: `agy --add-dir .` from the repo root (or `agy --project <name>` if it's already
  registered). The first run will prompt to trust the workspace and to approve each tool
  permission (reading `AGENTS.md`, listing skills, etc.): say yes and persist it, so subsequent
  runs don't re-prompt.
- **IDE**: open the repo folder directly; Antigravity registers open folders as workspaces
  automatically.

If `agy mcp list` or a prompt like "what skills/MCP servers do you have?" comes back empty, this is
almost always why: the workspace was never registered, not a broken `.mcp.json`.

Everything else (coordinate systems, held-input persistence, the single-holder port 9090, real time
passing between tool calls) applies the same way it does for Claude Code; see `CLAUDE.md` for the
details even though `agy` won't read that file itself.
