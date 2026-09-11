extends Control

## Phase 0 throwaway scene: proves the translation pipeline, runtime locale
## switching, and RTL mirroring all work together. Delete at Phase 4 once the
## real settings menu exists. See docs/plan/phase-0-foundations.md.

@onready var _status_label: Label = %StatusLabel

func _ready() -> void:
	LocaleManager.locale_changed.connect(_on_locale_changed)
	_update_status()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_cycle_locale"):
		LocaleManager.cycle_locale()

func _on_locale_changed(_locale: String) -> void:
	_update_status()

func _update_status() -> void:
	_status_label.text = "%s / rtl=%s" % [
		TranslationServer.get_locale(),
		is_layout_rtl(),
	]
