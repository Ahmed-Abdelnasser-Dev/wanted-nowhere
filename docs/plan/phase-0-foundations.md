# Phase 0: Foundations

**Goal:** the English/Arabic translation pipeline works end to end, before any real UI exists to
retrofit it onto.

**Depends on:** nothing. This is the first phase.

**Done when:** a throwaway label in `game_scene.tscn` renders an English string, a runtime toggle
switches it to Arabic with correct shaping, and the layout mirrors right to left.

## 0.1 Translation pipeline

- [ ] Create `assets/i18n/strings.csv` with `keys`, `en`, `ar` columns (Godot's CSV translation
  import format).
- [ ] Add a handful of seed keys to prove the format, for example `UI_MENU_START`, `UI_MENU_QUIT`.
- [ ] Let Godot import the CSV as `.translation` resources (automatic on import once the file is
  added to the project).
- [ ] Register the imported translations in `project.godot` under
  `internationalization/locale/translations`.

**Verify:** `godot --headless --path . --quit` still loads with no import errors, and the Godot
editor's Project Settings → Localization tab lists both `en` and `ar` translations.

**Files:** `assets/i18n/strings.csv`, `project.godot`.

## 0.2 Locale switching and RTL layout

- [ ] Add a way to set the active locale at runtime (`TranslationServer.set_locale("ar")`), exposed
  for now as a debug key or `game_eval` call since there is no settings menu yet.
- [ ] Confirm `Control.layout_direction` follows the locale automatically and that a test `Control`
  node's anchors don't fight it (no hardcoded left-alignment that ignores RTL).

**Verify:** with `run_project`, flip locale to `ar` via `game_eval`, screenshot, confirm the test
label's text and alignment mirrored.

**Files:** wherever the debug toggle lives (a small script on `game_scene.tscn` is enough for this
phase; it can be deleted once Phase 4 builds the real settings menu).

## 0.3 Font coverage

- [ ] Pick a font setup that renders both Latin and Arabic glyphs with correct contextual shaping.

Three options, see the tradeoffs below; start with option 3 and revisit at Phase 4 once the real UI
exists to judge it against:

1. **A pixel font with Arabic coverage.** Best visual consistency with the rest of the pixel-art
     game, hardest to source or commission.
2. **A normal Arabic TTF for UI text only**, accepting it reads crisper than the pixel art around
     it. Common in pixel-art games shipping non-Latin locales; lowest risk.
3. **Godot's fallback font chain**: pixel font first, an Arabic-capable font behind it for glyphs the
     pixel font lacks. Simplest to set up now; mixed weights on one line can look inconsistent, worth
     a second look once real UI text exists.

- [ ] Apply the chosen font (or fallback chain) to the test label from 0.2 and confirm Arabic glyphs
  render correctly shaped, not as boxes or disconnected letterforms.

**Verify:** screenshot of the test label in Arabic; letters should connect the way Arabic script
requires, not render as isolated forms.

**Files:** a font resource under `assets/` (location depends on what gets picked), the test label's
scene.

## 0.4 The convention

- [ ] Add the "Localization" section to `AGENTS.md` if not already present (it is, as of this
  writing; keep it in sync if the pipeline design changes during this phase).
- [ ] Confirm every phase file from 1 onward carries the "Standing constraints" block referencing
  this convention.

**Verify:** re-read `AGENTS.md` → "Localization" and confirm it matches what actually got built in
0.1 through 0.3, not just what was planned.

**Files:** `AGENTS.md`.
