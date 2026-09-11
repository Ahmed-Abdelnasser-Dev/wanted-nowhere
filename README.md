# Wanted Nowhere

A 2D top-down rogue-like built in Godot, set in a fantasy world where you play as a vampire hunted by
both humans and monsters — constantly fighting, constantly healing.

Days and nights cycle. You avoid the sun by day using the **shadow**, and unlock your full power at
night. Moon cycles matter too — you're stronger under a full moon. Combat feeds experience, and
experience offers upgrade cards for your stats and abilities.

## Abilities

Move with right-click, melee attack with left-click (a 3-hit combo: slash, slash, triple-slash), and
four abilities bound to **Q W E R**:

| | Normal Phase | Ascended Phase (R to enter, 30s duration, 90s cooldown) |
|---|---|---|
| **Q** | Shadow Movement — dash that damages & knocks back | Death Dance — dash that also spikes the ground; dash twice in a row |
| **W** | Bat/Human Shape — faster & smaller as a bat, immune for 2s, less sun damage | Wake the Dead — summon fighting ghosts |
| **E** | Blood Blast — AoE damage + 0.5s slow | Blink of the Death — execute nearby enemies, slow/damage further out |
| **R** | Ascend into the Ascended Phase | End ascension early, refunding unused duration to the cooldown |

Enemies come in two families — **Human** and **Monster** — each with their own bosses.

The game is planned for **English and Arabic**, targeting **Desktop, Web, and Mobile**.

## Status

Pre-alpha scaffold. No gameplay is implemented yet — no player script, no input bindings, just the
empty main scene and the imported art/tile assets. See `AGENTS.md` for current known gaps.

## Requirements

- [Godot Engine 4.7.2](https://godotengine.org/download) (GL Compatibility renderer). An exact
  version match matters if you intend to export — see `AGENTS.md`.

## Running it

```sh
godot --path .          # open in the editor
godot --headless --path . --quit   # headless sanity check (loads, no scene/import errors)
```

## Repository layout

```text
scenes/    .tscn scene files
scripts/   GDScript, mirrors scenes/
assets/
  characters/vampire_normal/, vampire_ascended/   sprite sheets per phase & action
  tiles/, objects/                                 top-down tileset and scenery
docs/
  idea/        original design pitch
  plan/        planning docs
  technical/   technical design docs
```

## Contributing / agent setup

This repo is developed with AI coding agents (Claude Code and Antigravity) alongside manual work.
`AGENTS.md` is the canonical brief for design pillars, conventions, and how to reproduce the local
MCP/skills harness from a fresh clone.

## Credits

Character and tile art credits: TBD.
