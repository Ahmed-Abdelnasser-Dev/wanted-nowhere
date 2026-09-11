# Phase 0: Foundations

**Goal:** the English/Arabic translation pipeline works end to end, before any real UI exists to
retrofit it onto.

**Depends on:** nothing. This is the first phase.

**Done when:** a throwaway dev scene renders an English string, a runtime toggle switches it to
Arabic with correct shaping, and the layout mirrors right to left. Done, see `scenes/dev/locale_test.tscn`.

## 0.1 Translation pipeline

- [x] Create `assets/i18n/strings.csv` with `keys`, `en`, `ar` columns (Godot's CSV translation
  import format).
- [x] Add a handful of seed keys to prove the format, for example `UI_MENU_START`, `UI_MENU_QUIT`.
  Eight keys landed: the Phase 4 menu spine, two ability names, one value with a quoted comma, and
  one mixing Arabic text with Latin digits to prove bidi ordering.
- [x] Let Godot import the CSV as `.translation` resources (automatic on import once the file is
  added to the project). They land next to the CSV as `strings.en.translation` /
  `strings.ar.translation` and are tracked in git since `project.godot` references them by path.
- [x] Register the imported translations in `project.godot` under
  `internationalization/locale/translations`. `locale/fallback` is set to `"en"`.

**Verify:** `godot --headless --path . --quit` loads with no import errors, and
`TranslationServer.get_loaded_locales()` returns both `en` and `ar`. Confirmed via `game_eval`.

**Files:** `assets/i18n/strings.csv`, `assets/i18n/strings.en.translation`,
`assets/i18n/strings.ar.translation`, `project.godot`.

## 0.2 Locale switching and RTL layout

- [x] Add a way to set the active locale at runtime. Built as a real `LocaleManager` autoload
  (`scripts/autoload/locale_manager.gd`) rather than a throwaway, since Phase 4's settings menu
  needs the same `set_locale()` / `cycle_locale()` / `locale_changed` signal surface. It persists
  the choice to `user://settings.cfg`. A single `InputMap` action, `debug_cycle_locale` (F9), drives
  it for now.
- [x] Confirm `Control.layout_direction` follows the locale automatically and that a test `Control`
  node's anchors don't fight it. `internationalization/rendering/root_node_layout_direction` is set
  to "Based on Application Locale" (0), so `is_layout_rtl()` follows whatever `LocaleManager` sets.
  The dev scene deliberately leaves every Control at its default alignment and anchors, no hardcoded
  `HORIZONTAL_ALIGNMENT_LEFT`, and layout direction alone produces correct mirroring.

**Verify:** with `run_project`, flip locale to `ar` via the F9 action, screenshot, confirm the dev
scene's text and its `HBoxContainer` child order both mirrored. Confirmed: English and Arabic
screenshots both taken, `HBoxContainer` children reversed order in Arabic, status label reported
`ar` / `rtl=true`. Locale also persists and restores correctly across a full stop/relaunch.

**Files:** `scripts/autoload/locale_manager.gd`, `scenes/dev/locale_test.tscn`,
`scripts/dev/locale_test.gd`, `project.godot`.

## 0.3 Font coverage

- [x] Pick a font setup that renders both Latin and Arabic glyphs with correct contextual shaping.

**Decision: option 1, a single pixel font with real Arabic coverage, no fallback chain.**
`assets/fonts/PixelAE-{Regular,Bold}.ttf` (added alongside this phase) turned out to already carry
55 Arabic-block codepoints, 89 Arabic Presentation Forms-B glyphs, and a GSUB table with `arab`
script plus `init`/`medi`/`fina`/`rlig` features, so this was available from the start rather than
something to build up to. Known limit: no tashkeel (U+064B-0652), so in-game Arabic stays
unvocalized; revisit if a string ever needs diacritics.

- [x] Apply the chosen font to the dev scene and confirm Arabic glyphs render correctly shaped, not
  as boxes or disconnected letterforms. Applied via `assets/ui/main_theme.tres`
  (`gui/theme/custom` in `project.godot`), `default_font_size = 10`. Both `.ttf.import` files were
  also switched from Godot's smooth-text defaults to pixel-rendering settings: `antialiasing`,
  `hinting`, and `subpixel_positioning` all set to their `NONE`/`DISABLED` value (0). Canvas texture
  filtering project-wide was also switched to Nearest
  (`rendering/textures/canvas_textures/default_texture_filter=0`), since the project had been
  running on Godot's linear default despite the pixel-perfect integer-scaled viewport.

**Verify:** screenshot of the dev scene in Arabic; letters connect the way Arabic script requires.
Confirmed visually (see 0.2's screenshots), and confirmed directly: `TextServerManager` reports the
Advanced (ICU / HarfBuzz / Graphite) interface, and shaping "لا" (lam + alef, 2 characters) collapses
to a single glyph, proving the lam-alef ligature fires.

**Files:** `assets/ui/main_theme.tres`, `assets/fonts/PixelAE-Regular.ttf.import`,
`assets/fonts/PixelAE-Bold.ttf.import`, `project.godot`.

## 0.4 The convention

- [x] Add the "Localization" section to `AGENTS.md` if not already present, and keep it in sync with
  what actually shipped: the `LocaleManager` autoload, the closed font decision, and the RTL layout
  direction setting.
- [x] Confirm every phase file from 1 onward carries the "Standing constraints" block referencing
  this convention. Verified: phases 1 through 5 all have it.

**Verify:** re-read `AGENTS.md` → "Localization" and confirm it matches what actually got built in
0.1 through 0.3, not just what was planned. Confirmed.

**Files:** `AGENTS.md`.
