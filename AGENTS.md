# AGENTS.md

Canonical brief for any agent working on **Wanted Nowhere** — read by Claude Code and Antigravity
(`agy`) alike. Tool-specific notes live in `CLAUDE.md` and `GEMINI.md`; both of those point back here
for everything shared.

## What this is

A 2D top-down rogue-like built in **Godot 4.7 (GDScript)**, targeting **Desktop, Web, and Mobile**.
You play a vampire hunted by both humans and monsters, in constant fighting. See
`docs/idea/Game Idea.md` and `docs/idea/Player.md` for the full design source — this section is a
compressed version; when the two disagree, the docs win.

Design pillars that constrain every change:

- **Day/night + shadow.** Days and nights cycle; the sun damages you, the **shadow** shields you.
  Full power comes at night. Moon cycles matter too — you're stronger under a full moon.
- **Constant combat, constant healing.** As a vampire you heal from combat itself. EXP from fighting
  offers upgrade cards for stats/abilities.
- **Two phases, four abilities each**, bound to QWER while moving/attacking with the mouse
  (right-click move, left-click melee — 3-hit combo: slash, slash, triple-slash):
  - **Normal** — Q Shadow Movement (dash, damage+knockback), W Bat/Human transform, E Blood Blast
    (AoE slow), R Ascend (30s buff, 90s cooldown).
  - **Ascended** — Q Death Dance (double-dash + ground spikes), W Wake the Dead (ghost minions),
    E Blink of the Death (execute + slow/damage ring), R ends ascension early, refunding cooldown
    proportional to time left.
- **Two enemy families** — Human and Monster — each with bosses.
- **English and Arabic.** No hardcoded user-facing strings; UI must tolerate RTL layout.

## Rendering contract

`project.godot`: viewport `640x360`, window `1280x720`, `stretch/mode=viewport`,
`stretch/aspect=keep_height`, `scale_mode=integer`, renderer `gl_compatibility` (both desktop and
mobile). This is a deliberate pixel-perfect, low-power choice made for the Web/Mobile targets —
don't switch renderers or drop integer scaling without a real reason.

## Layout

- `scenes/` — `.tscn` files. `game_scene.tscn` is the current (empty) main scene.
- `scripts/` — mirrors `scenes/`, one script per scene/node as the project grows.
- `assets/characters/{vampire_normal,vampire_ascended}/{Idle,Walk,Run,Attack,Hurt,Death}/` — sprite
  sheets, each phase already split into `_body`, `_head`, `_shadow`, `_full` (and `_magic`/`_red` for
  Attack/Death) layers.
- `assets/tiles/`, `assets/objects/` — top-down tileset and scenery.
- `docs/idea/`, `docs/plan/`, `docs/technical/` — design source of truth.

## GDScript conventions

Drawn from the skills installed under `.agents/skills/` (see "Local harness setup" below) — read the
relevant skill before writing non-trivial GDScript rather than re-deriving these from scratch:

- Static typing everywhere; `class_name` on reusable types.
- Signal-up / call-down: children emit signals, parents connect to them — never `get_parent().method()`.
- Signal object syntax (`button.pressed.connect(_on_pressed)`), never string-based `connect(...)`.
- No `get_node()` / `$` lookups inside `_process()` — cache via `@onready`.
- Composition over inheritance for gameplay pieces (abilities, stats, combat).
- Data belongs in `.tres` resources, not hardcoded constants, once there's more than one instance of
  it (enemy stats, ability params, upgrade cards).

## Verifying changes

There is **no test framework, linter, or CI** in this project. Verification means running the game
and looking at it:

```sh
godot --headless --path . --quit    # sanity check: loads, no import/scene errors
```

With the `godot` MCP server connected (see below), the loop is `run_project` → interact
(`game_click`, `game_key_press`, …) → `game_screenshot` / `game_eval` to inspect state →
`game_performance` if relevant. `validate_script` catches syntax/type errors without a running game.
Only one process can hold the runtime bridge's port 9090 at a time, and real time passes between
tool calls (timers, drains, AI keep running while you inspect) — factor that in.

## Local harness setup

`.agents/`, `.mcp.json`, `.claude/`, and `skills-lock.json` are **gitignored** — they're per-developer
agent tooling, not game code. A fresh clone needs this to get the same setup:

1. **Godot MCP server** — built from <https://github.com/tugcantopaloglu/godot-mcp> (157 tools: scene
   editing, runtime `game_*` inspection/control, autoload management, script validation, etc.).
   Build it once (`npm install && npm run build`), then put a small shim named `godot-mcp` on your
   `PATH`:

   ```sh
   #!/bin/sh
   export GODOT_PATH=/usr/bin/godot   # or wherever your Godot 4.7.2 binary lives
   exec node /path/to/godot-mcp/build/index.js "$@"
   ```

2. **Project `.mcp.json`** (repo root):

   ```json
   { "mcpServers": { "godot": { "type": "stdio", "command": "godot-mcp", "args": [] } } }
   ```

3. **Runtime bridge** — copy the server's `build/scripts/mcp_interaction_server.gd` into the repo
   root and register it as the `McpInteractionServer` autoload in `project.godot` (already done in
   this repo's committed `project.godot`; only the `.gd` file itself is gitignored, so re-copy it).
   Without this file present, headless MCP tools still work but the `game_*` runtime tools won't.
4. **Skills** — 36 Godot skills live in `.agents/skills/` once set up, curated for this project's
   genre (2D top-down action roguelike): GDScript/signals/autoload/composition/state-machine
   fundamentals, characterbody/physics/combat/abilities/RPG-stats/roguelike/procgen/camera/save-load
   gameplay skills, 2D animation/tilemap/particles/shaders/tweening/audio presentation skills, UI +
   theming, and mobile/web/export/performance/debugging/testing ops skills. Sourced from
   `thedivergentai/gd-agentic-skills`, `pluginagentmarketplace/custom-plugin-game-developer`, and
   `zate/cc-godot` — see `skills-lock.json` for the exact mapping once regenerated, or copy directly
   from another local Godot project that already has the full set.
5. **Antigravity workspace registration** — `agy` does not auto-detect a cwd as a project the way
   Claude Code does. Run `agy --add-dir .` from the repo root once (or open the folder in the
   Antigravity IDE) and approve the trust/permission prompts; only then will it read `AGENTS.md`,
   `.agents/skills/`, and `.mcp.json`. See `GEMINI.md` for details.

## Known gaps (not yet built)

- No `InputMap` entries — right-click move, left-click attack, QWER abilities all need binding.
- No player scene/script — `game_scene.tscn` is an empty `Node2D`.
- Export templates installed are `4.7.stable`/`4.7.1.stable`; the engine is `4.7.2.stable`. Godot
  requires an exact match, so exporting will fail until matching templates are installed.
