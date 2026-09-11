# Phase 5: Game Loop and Upgrades

**Goal:** close the loop: combat earns XP, XP triggers upgrade-card choices that modify the player's
stats, death ends the run, and the whole thing is polished enough to call a demo.

**Depends on:** Phase 1 (stats resource to upgrade), Phase 3 (enemies to earn XP from), Phase 4
(UI to present upgrade cards and the game-over/restart flow).

**Done when:** a full run is playable start to finish: fight, gain XP, level up, pick an upgrade,
keep fighting, eventually die, see a game-over screen, and restart, all without a crash or a
placeholder screen.

## Standing constraints

Applies to every milestone in this phase.

- No hardcoded user-facing strings. Every one goes through a translation key (see Phase 0), upgrade
  card names and descriptions included.
- Any new UI (upgrade card picker, game-over screen) is checked in both `en` and `ar`.
- No em dashes in code comments or displayed text (see `AGENTS.md` → "Writing style").

## 5.1 XP accrual

- [ ] Wire Phase 3's `enemy_died` signal (or equivalent) to award XP to the player.
- [ ] An XP/level curve: how much XP each level requires, stored as data rather than hardcoded
  per-level numbers (a simple formula or a small resource table both work; pick whichever keeps
  tuning easy).

**Verify:** `run_project`, kill a few enemies, confirm the HUD's XP bar (built in Phase 4) fills and
a level-up triggers at the expected threshold.

**Files:** `scripts/player/player_xp.gd` or similar, connected to the Phase 3 enemy base.

## 5.2 Upgrade cards

- [ ] A pool of upgrade cards, each a data resource describing what it modifies (a stat boost, a
  cooldown reduction, an ability tweak) rather than a hardcoded switch statement per card.
- [ ] On level-up, present a choice of cards (2 to 3 is typical for this genre) and pause or slow
  the game while choosing.
- [ ] Applying a chosen card modifies the Phase 1 `CharacterStats` resource (or the relevant ability
  parameter) at runtime.

**Verify:** `run_project`, level up, confirm the card-choice UI appears, pick a card, confirm the
corresponding stat actually changed (for example, movement speed increased, visible in the HUD or
by feel).

**Files:** `scripts/systems/upgrade_card.gd` (resource script), a set of `.tres` card instances,
`scenes/ui/upgrade_picker.tscn`.

## 5.3 Death and restart

- [ ] Death triggers a game-over screen (built in Phase 4's UI layer, or added here if not yet
  present) rather than the game silently stopping.
- [ ] Restart resets the player, world state (day/night/moon cycle), and enemies to a fresh run,
  without requiring a full process restart.

**Verify:** `run_project`, let the player die (or force it via `game_eval` for a faster loop),
confirm the game-over screen appears and Restart produces a clean fresh run, not leftover enemies or
stale stats from the previous run.

**Files:** `scripts/systems/game_state.gd` or similar, `scenes/ui/game_over.tscn`.

## 5.4 Demo polish pass

- [ ] Play through a full run start to finish and fix anything that breaks immersion: missing
  sounds, UI elements that don't update, pacing that feels too slow or too fast for XP gain or enemy
  spawn rate.
- [ ] Confirm the whole loop works correctly in Arabic as well as English: this is the first point
  where every system built across all five phases runs together, so it's the real end-to-end
  localization check.

**Verify:** two full playthroughs, one in each locale, each from main menu through a run to death
and restart, with no crashes, missing text, or broken layout.

**Files:** whatever the playthrough surfaces; this milestone is a bugfix pass, not new systems.

## What comes after

Deliberately undecided. This phase's output is a playable demo of the core loop; the next roadmap
gets written once that demo has been played.
