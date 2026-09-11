# Phase 1: Player

**Goal:** a complete, playable vampire, movement, combat, both forms, all eight abilities, with
nothing to fight yet.

**Depends on:** Phase 0 (translation pipeline; ability names and tooltips go through keys from the
start, not as a later retrofit).

**Done when:** you can run the project, right-click to move, left-click to run the 3-hit combo, cast
all four Normal abilities, Ascend, cast all four Ascended abilities, and take/deal damage with
matching VFX and SFX, all governed by a stats resource instead of hardcoded numbers.

## Standing constraints

Applies to every milestone in this phase.

- No hardcoded user-facing strings. Every one goes through a translation key (see Phase 0).
- Any new UI (ability names, tooltips, damage numbers) is checked in both `en` and `ar`, including
  RTL mirroring and Arabic glyph shaping.
- No em dashes in code comments or displayed text (see `AGENTS.md` → "Writing style").

## 1.1 Movement, sprites, animation

- [ ] Add `InputMap` entries: `move_click` (right mouse button), `attack_click` (left mouse button),
  `ability_q`, `ability_w`, `ability_e`, `ability_r`.
- [ ] Create `scenes/player/player.tscn` as a `CharacterBody2D` with the layered sprite structure
  the art already assumes (`_body`, `_head`, `_shadow`, `_full` sub-sprites).
- [ ] `scripts/player/player.gd`: click-to-move via `move_and_slide()`, static typed, no `$` lookups
  in `_process()`.
- [ ] Slice the `assets/characters/vampire_normal/{Idle,Walk,Run,Hurt,Death}/` sheets into
  `SpriteFrames` and wire an Idle/Walk/Run/Hurt/Death state machine (see the
  `godot-state-machine-advanced` and `godot-characterbody-2d` skills before writing this).

**Verify:** `run_project`, right-click on the ground, the vampire paths there and the Walk/Run
animation plays; releasing the click settles back to Idle.

**Files:** `scenes/player/player.tscn`, `scripts/player/player.gd`, `project.godot` (InputMap).

## 1.2 Attack and the 3-hit combo

- [ ] Left-click triggers the combo: slash, slash, triple-slash, using
  `assets/characters/vampire_normal/Attack/`.
- [ ] Combo window timing: a follow-up click within the window advances the combo, outside it resets
  to the first slash.
- [ ] Hit detection for each combo step (see the `godot-combat-system` skill for hitbox/hurtbox
  patterns already curated for this project).
- [ ] Attack VFX per combo step, distinct enough that the triple-slash reads as the finisher.

**Verify:** `run_project`, chain three left-clicks inside the combo window and confirm all three
animations play in sequence with their VFX; wait past the window and confirm it resets to slash one.

**Files:** `scripts/player/player.gd` (or a split-out `scripts/player/player_combat.gd` if the
combo logic grows large), a hitbox scene under `scenes/player/`.

## 1.3 Normal-phase abilities and camera

- [ ] Q, Shadow Movement: dash that damages and knocks back enemies in its path.
- [ ] W, Bat/Human transform: faster and smaller as a bat, immune for the first 2s, reduced sun
  damage; transforming back to human loses these effects.
- [ ] E, Blood Blast: circular AoE damage plus a 0.5s slow.
- [ ] R, Ascend: enters the Ascended phase (see 1.4) for 30s, 90s cooldown.
- [ ] Follow camera with deadzone and limits so the vampire stays framed during movement and dashes.

**Verify:** `run_project`, trigger each of Q/W/E and confirm damage/knockback, transform, and
AoE/slow behave as described; the camera should not jitter or clip off-vampire during a dash (this
project already has camera-smoothing lessons learned; see the `godot-camera-systems` skill).

**Files:** `scripts/player/abilities/` (one script per ability, composition over inheritance per
`AGENTS.md`), `scenes/player/player_camera.tscn` or similar.

## 1.4 Ascended form

- [ ] Slice `assets/characters/vampire_ascended/` the same way as 1.1 did for the normal form.
- [ ] Ascend/Descend transition: a staged transformation sequence (visual and mechanical), 30s
  duration, 90s cooldown starting on Ascend.
- [ ] Q, Death Dance: dash that also spikes the ground; can dash twice in a row.
- [ ] W, Wake the Dead: summons ghost minions that fight alongside the vampire.
- [ ] E, Blink of the Death: executes enemies in a small inner radius, slows and damages in a larger
  outer radius (make the two radii read as visually distinct zones).
- [ ] R, early exit: ends ascension before the 30s expire, refunding the 90s cooldown proportional
  to the time left unused.

**Verify:** `run_project`, Ascend, confirm the transform sequence plays and stats change (see 1.6),
cast all three Ascended abilities, then R early and confirm the cooldown refund is proportional, not
full or zero.

**Files:** `scripts/player/player_forms.gd` (or similar), `scripts/player/abilities/` (ascended
variants).

## 1.5 VFX and SFX pass

- [ ] Sounds for: each combo step, each of the eight abilities, taking damage, and death.
- [ ] Any VFX stubbed as placeholders in 1.2 through 1.4 gets its real effect.
- [ ] Camera shake and hit-stop scaled to the moment (a light attack should not shake the camera as
  hard as Ascend does).

**Verify:** `run_project`, play through combo, all eight abilities, take damage, and die, confirming
audio plays for each and nothing is silent or missing.

**Files:** `assets/` audio (new directory if one does not exist yet), `scripts/player/` (wiring).

## 1.6 Base stats

- [ ] A `.tres` `CharacterStats` resource holding health, movement speed, damage, and per-ability
  cooldowns, following the `godot-rpg-stats` skill's data-driven pattern.
- [ ] Player reads all tunable numbers from this resource, not from hardcoded constants in
  `player.gd`.
- [ ] Ascended-form stat deltas (faster, stronger) are expressed as modifiers on the same resource,
  not a second hardcoded set of numbers.

**Verify:** change a value in the `.tres` file in the editor (for example, movement speed), rerun,
confirm the change takes effect with no code edit.

**Files:** `scripts/player/character_stats.gd` (resource script), a `.tres` instance under
`scenes/player/` or `assets/data/`.

This groundwork is what Phase 5's upgrade cards will modify; the XP system itself is built in
Phase 5, not here.
