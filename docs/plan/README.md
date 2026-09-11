# Plan

Task lists for building Wanted Nowhere in order, one file per phase. Each phase file is written to
be picked up cold: it names a goal, breaks it into milestones with checkbox tasks, and states how to
verify each milestone. Check off tasks as they land; when a phase's "Done when" condition is true,
move to the next one.

Source of truth for the design itself is `docs/idea/`; these files are the build order layered on
top of it. When the two disagree, `docs/idea/` wins and this plan gets corrected.

## Phases

| Phase | File | Goal |
| --- | --- | --- |
| 0 | [phase-0-foundations.md](phase-0-foundations.md) | Translation pipeline and the localization convention, before any UI exists to retrofit |
| 1 | [phase-1-player.md](phase-1-player.md) | A complete, playable vampire: movement, combat, both forms, all eight abilities, stats |
| 2 | [phase-2-world.md](phase-2-world.md) | The world to fight in: tiles, day/night and moon cycles, real-time shadows, collision |
| 3 | [phase-3-enemies.md](phase-3-enemies.md) | Human and Monster enemies, melee and ranged, bosses, spawning |
| 4 | [phase-4-ui-and-menus.md](phase-4-ui-and-menus.md) | HUD, main menu, settings, credits, all interactive and animated |
| 5 | [phase-5-game-loop.md](phase-5-game-loop.md) | XP, upgrade cards, death/restart: the full loop as a playable demo |

## Status

Phase 0 not started. Nothing past the empty scaffold described in `AGENTS.md` → "Known gaps" exists
yet.

## What comes after the demo

Deliberately undecided. Phase 5 ends with a playable demo loop; the next roadmap gets written once
that demo has been played.
