# Phase 3: Enemies

**Goal:** a sophisticated, data-driven enemy system covering Human and Monster families, melee and
ranged behavior, a boss per family, and spawning that keeps the world populated.

**Depends on:** Phase 1 (something for enemies to fight and be fought by) and Phase 2 (a world with
collision and arena spaces for enemies and bosses to occupy).

**Done when:** melee and ranged Human and Monster enemies spawn into the world at a sensible rate,
fight the player, die and despawn cleanly, and each family has a boss fight that uses the arena
layout from Phase 2.

## Standing constraints

Applies to every milestone in this phase.

- No hardcoded user-facing strings. Every one goes through a translation key (see Phase 0), enemy
  names and boss names included.
- Any new UI (boss health bars, spawn telegraphs) is checked in both `en` and `ar`.
- No em dashes in code comments or displayed text (see `AGENTS.md` → "Writing style").

## 3.1 Shared enemy base

- [ ] A base enemy scene/script (`CharacterBody2D` + shared state machine) that every enemy type
  extends or composes, not copy-pasted per type (composition over inheritance, per `AGENTS.md`).
- [ ] An `EnemyStats` `.tres` resource (health, damage, speed, aggro range), following the same
  pattern as Phase 1's `CharacterStats` (see `godot-rpg-stats`).
- [ ] Shared death handling: despawn, drop hooks for Phase 5's XP system to attach to later (an
  `enemy_died` signal is enough for now; the XP payout itself is Phase 5's job).

**Verify:** a single placeholder enemy (a training-dummy-style stand-in) spawns, takes damage from
the Phase 1 attack, and despawns on death.

**Files:** `scripts/enemies/enemy_base.gd`, `scripts/enemies/enemy_stats.gd`.

## 3.2 Melee and ranged behavior

- [ ] Melee behavior: approach, attack when in range, back off or reposition on cooldown.
- [ ] Ranged behavior: keep distance, attack on line of sight, reposition if the player closes in.
- [ ] Both behaviors built as swappable components on the shared base from 3.1, not a branching
  `if is_ranged` inside one script (see `godot-state-machine-advanced` for the pattern).

**Verify:** spawn one melee and one ranged placeholder enemy, confirm the melee one closes distance
and the ranged one holds it, each attacking appropriately.

**Files:** `scripts/enemies/behaviors/melee_behavior.gd`, `scripts/enemies/behaviors/ranged_behavior.gd`.

## 3.3 Human and Monster families

- [ ] At least one melee and one ranged enemy for the Human family (per `docs/idea/World.md`:
  knights, archers, holy magicians or similar), using the shared base and behaviors from 3.1/3.2.
- [ ] At least one melee and one ranged enemy for the Monster family (per `docs/idea/World.md`:
  zombies, skeletons, orcs, or similar).
- [ ] Distinct sprites/animations per enemy, following the same layered-sheet convention as the
  player where the art supports it.

**Verify:** `run_project`, spawn one of each of the four enemy types, confirm each looks, moves, and
attacks distinctly.

**Files:** `scenes/enemies/human/`, `scenes/enemies/monster/`, matching `scripts/enemies/human/`,
`scripts/enemies/monster/`.

## 3.4 Bosses

- [ ] One boss per family, built on the shared base but with a larger stats resource and a
  multi-phase or telegraphed attack pattern distinct from regular enemies.
- [ ] Wire the boss encounter into the arena layout reserved in Phase 2 (bordered space, no free
  roaming during the fight).

**Verify:** `run_project`, trigger a boss encounter, confirm the arena border holds (the player
cannot walk out of the fight) and the boss's attack pattern plays out over multiple phases if
designed with any.

**Files:** `scenes/enemies/bosses/`, `scripts/enemies/bosses/`.

## 3.5 Spawning

- [ ] Spawn points placed across the world sections from Phase 2, weighted toward matching enemy
  families to matching sections (Monsters in the forest, Humans in the city, for example, if that
  matches the design intent, otherwise a simpler uniform distribution is fine to start).
- [ ] A spawn-rate system: enemies spawn over time up to a population cap, replacing ones that died.
- [ ] Cleanup: despawn enemies that wander too far from the player or from any spawn point, to avoid
  unbounded growth.

**Verify:** `run_project`, let the game run for a few minutes via `game_wait`, confirm the enemy
population stabilizes near the intended cap rather than growing unbounded or dropping to zero.

**Files:** `scripts/world/enemy_spawner.gd` (or similar), referencing the spawn points placed in
`scenes/world/`.
