# Wanted Nowhere

A 2D top-down roguelike built in **Godot 4.7**. You play as a vampire hunted by both humans and monsters, always fighting and always healing.

> **Status: pre-alpha.** The design, art, and tiles are in place. Gameplay is being built. See [AGENTS.md](AGENTS.md) for known gaps.

## The idea

- **Day and night cycle.** Hide from the sun in the shadows by day, unlock your full power at night.
- **Moon phases matter.** You are strongest under a full moon.
- **Two enemy families,** Human and Monster, each with their own bosses.
- **Progression through combat.** Fighting earns experience, and experience offers upgrade cards for your stats and abilities.

## Abilities

Move with right-click. Melee with left-click in a 3-hit combo: slash, slash, triple-slash. Four abilities sit on **Q W E R**:

| Key | Normal Phase | Ascended Phase (30s, 90s cooldown) |
|---|---|---|
| **Q** | **Shadow Movement:** a dash that damages and knocks back | **Death Dance:** the dash also spikes the ground, and you can dash twice |
| **W** | **Bat / Human Shape:** a faster, smaller bat form, immune for 2s, takes less sun damage | **Wake the Dead:** summon ghosts that fight for you |
| **E** | **Blood Blast:** area damage plus a 0.5s slow | **Blink of Death:** execute nearby enemies, slow and damage those further out |
| **R** | Ascend into the Ascended Phase | End ascension early and refund the unused time to the cooldown |

## Platforms and languages

Planned for **desktop, web, and mobile**, in **English and Arabic**.

## Running it

Requires [Godot 4.7.2](https://godotengine.org/download) (GL Compatibility renderer). Match the version exactly if you plan to export.

```bash
godot --path .                      # open in the editor
godot --headless --path . --quit    # quick check that the project loads cleanly
```

## Project layout

```
scenes/     Scene files
scripts/    GDScript, mirrors scenes/
assets/
  characters/   Vampire sprite sheets for each phase and action
  tiles/        Top-down tileset
  objects/      Scenery
docs/
  idea/         Original design pitch
  plan/         Planning docs
```

## How it is built

Developed with AI coding agents (Claude Code and Antigravity) alongside hand-written work. [AGENTS.md](AGENTS.md) holds the design pillars, conventions, and agent setup.

## Credits

Design and code by **Ahmed Abdelnasser**. Character and tile art credits coming soon.
