# Phase 2: World

**Goal:** a world to fight in: visible terrain and buildings, a day/night and moon cycle, real-time
shadows that gate sun damage, and collision on everything solid.

**Depends on:** Phase 1 (the player needs to exist to test sun damage, shadow detection, and
collision against).

**Done when:** the vampire can walk a real map with distinct sections (forest, city, castle, water
per `docs/idea/World.md`), day turns to night and back on a visible clock, the moon cycles and a full
moon is detectable, shadows move with the sun and the player takes sun damage only when outside one,
and buildings/trees/objects block movement.

## Standing constraints

Applies to every milestone in this phase.

- No hardcoded user-facing strings. Every one goes through a translation key (see Phase 0).
- Any new UI (a day/night indicator, debug overlays meant to ship) is checked in both `en` and `ar`.
- No em dashes in code comments or displayed text (see `AGENTS.md` → "Writing style").

## 2.1 Tiles and terrain blockout

- [ ] Build a `TileMap`/`TileSet` from `assets/tiles/` covering the sections `docs/idea/World.md`
  describes: forest, city, castle, and water/sea, as a single big open map (see
  `godot-tilemap-mastery`).
- [ ] Place `assets/objects/` scenery (props, foliage, structures) to make each section visually
  distinct, not just a different tile palette.
- [ ] Reserve space or a separate area for a boss-arena layout: `docs/idea/World.md` describes bosses
  fighting in a bordered arena (rocks, wood, or similar), distinct from the open map.

**Verify:** `run_project`, walk the player (from Phase 1) across each section by eye; screenshot each
section to confirm it reads as forest/city/castle/water distinctly.

**Files:** `scenes/world/` (new), a `TileSet` resource, object-placement scenes.

## 2.2 Day/night and moon cycle

- [ ] A day/night cycle: a clock that advances over real or scaled time, driving a visual
  time-of-day change (lighting tint, or a `CanvasModulate`/2D light setup).
- [ ] A moon cycle layered on top, tracking a "month" of in-game days, with a queryable full-moon
  state (`docs/idea/Game Idea.md`: the vampire is stronger under a full moon).
- [ ] Both cycles run as an autoload or a single world-state node other systems can query, not
  duplicated logic per scene.

**Verify:** `game_eval` to fast-forward the clock (per `AGENTS.md`'s note on zeroing/scripting
time-based systems for deterministic testing) and confirm the lighting shifts from day to night and
a full moon is reachable and detectable.

**Files:** `scripts/world/day_night_cycle.gd` (or similar autoload), referenced from `project.godot`
if it becomes an autoload.

## 2.3 Real-time shadows and shadow detection

- [ ] Shadows cast by terrain/buildings/objects that move as the day/night cycle's sun angle
  changes (2D light + occluder setup, or a simpler baked-per-time-of-day approach if full dynamic
  shadow-casting proves too heavy for the `gl_compatibility` renderer; verify before committing to
  either).
- [ ] A query the player (and later, enemies) can call to check "is this position inside a shadow
  right now": this is what gates sun damage from `docs/idea/Game Idea.md` / `Player.md`.
- [ ] Wire the query into the player's sun-damage logic (stubbed in Phase 1 if not already present).

**Verify:** `run_project`, fast-forward to daytime via `game_eval`, walk the player into and out of a
cast shadow, confirm sun damage stops while inside and resumes outside.

**Files:** `scripts/world/shadow_caster.gd` or similar, `scripts/player/player.gd` (the query call
site).

## 2.4 Collision

- [ ] Collision shapes on all buildings, trees, and other solid objects placed in 2.1 (see
  `godot-2d-physics` and `game_add_collision` where the MCP tool can generate shapes from sprites).
- [ ] Confirm the player's `move_and_slide()` from Phase 1 respects the new collision layer without
  needing changes to `player.gd` itself (collision layers/masks should be the only wiring needed).

**Verify:** `run_project`, walk the player directly into a building/tree and confirm it blocks
movement instead of overlapping.

**Files:** the object scenes placed in 2.1, `project.godot` (physics layer names if not already
defined).
