# Phase 4: UI and Menus

**Goal:** a complete, interactive, animated UI layer: HUD during play, main menu, settings, and
credits, working correctly in both English and Arabic.

**Depends on:** Phase 0 (translation pipeline and the font-coverage decision made there gets
revisited here against real UI), Phase 1 (stats to display), Phase 3 (enemy/boss state to display).

**Done when:** the game is fully navigable from launch through settings and into a run, entirely
through UI, with no placeholder debug menus or `game_eval` calls standing in for player-facing
controls, in both locales.

## Standing constraints

Applies to every milestone in this phase.

- No hardcoded user-facing strings. Every one goes through a translation key (see Phase 0).
- Every screen built in this phase is checked in both `en` and `ar`, including RTL mirroring and
  Arabic glyph shaping; this is the phase where Phase 0's font-coverage choice gets a real test.
- No em dashes in code comments or displayed text (see `AGENTS.md` → "Writing style").

## 4.1 HUD

- [ ] Health display, tracking the Phase 1 `CharacterStats` resource.
- [ ] XP/level display, wired once Phase 5's XP system exists (this milestone can build the visual
  shell against dummy values first if Phase 5 is not yet done).
- [ ] Ability cooldown indicators for all eight Q/W/E/R abilities (Normal and Ascended), reflecting
  Phase 1's cooldown data.
- [ ] Clock and moon-phase indicator, reflecting Phase 2's day/night and moon cycle.

**Verify:** `run_project`, take damage and confirm the health display updates, cast an ability and
confirm its cooldown indicator fills correctly, fast-forward the world clock via `game_eval` and
confirm the clock/moon indicator tracks it.

**Files:** `scenes/ui/hud.tscn`, `scripts/ui/hud.gd`.

## 4.2 Main menu

- [ ] Start, Settings, Credits, Exit, as the primary navigation.
- [ ] Entry animation/transition into and out of the menu, not an instant cut (see
  `godot-ui-containers` and `godot-ui` skills for layout and animation patterns already curated).

**Verify:** `run_project` from a cold launch, confirm the main menu is the first thing shown and
every button navigates correctly.

**Files:** `scenes/ui/main_menu.tscn`, `scripts/ui/main_menu.gd`.

## 4.3 Settings

- [ ] Audio settings: master/music/SFX volume, using Godot's audio bus system.
- [ ] Video settings: at minimum resolution/window mode, respecting the integer-scaling contract in
  `AGENTS.md`, don't offer options that break pixel-perfect rendering.
- [ ] Language toggle: this is the real home for the locale switch stubbed as a debug toggle in
  Phase 0.

**Verify:** `run_project`, change each setting, confirm it takes effect immediately or on the
documented trigger (for example, a resolution change applying without a restart if that's the
chosen design), and confirm the language toggle switches the whole UI, not just the settings screen.

**Files:** `scenes/ui/settings.tscn`, `scripts/ui/settings.gd`.

## 4.4 Credits and exit

- [ ] Credits screen: art/asset attribution (the README's Credits section already has a TBD marker
  to fill in here).
- [ ] Exit flow: confirms before quitting if there's an active run in progress, otherwise quits
  cleanly.

**Verify:** `run_project`, open Credits and confirm it reads correctly in both locales, then confirm
Exit closes the game (or prompts correctly, per whatever the final design decides).

**Files:** `scenes/ui/credits.tscn`, wiring in `scripts/ui/main_menu.gd`.

## 4.5 Interaction and animation polish

- [ ] Hover/press states on every interactive UI element.
- [ ] Consistent transition timing across all menu screens (a shared tween/animation helper rather
  than one-off tweens per screen).

**Verify:** click through every menu screen built in this phase, confirm no element is missing a
hover or press state and transitions feel consistent rather than each screen having its own timing.

**Files:** likely a shared `scripts/ui/ui_transitions.gd` helper, referenced from each screen above.
