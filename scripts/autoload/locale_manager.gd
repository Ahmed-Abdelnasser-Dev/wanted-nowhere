extends Node

## Owns the active locale: switches it, persists the player's choice, and
## notifies listeners so UI can react (retranslate, re-mirror for RTL).
##
## Registered as the LocaleManager autoload. See AGENTS.md -> "Localization".

signal locale_changed(locale: String)

const SUPPORTED_LOCALES: PackedStringArray = ["en", "ar"]
const DEFAULT_LOCALE: String = "en"
const SETTINGS_PATH: String = "user://settings.cfg"
const SETTINGS_SECTION: String = "localization"
const SETTINGS_KEY: String = "locale"

var current_locale: String = DEFAULT_LOCALE


func _ready() -> void:
	_load_saved_locale()


func set_locale(locale: String) -> void:
	if not SUPPORTED_LOCALES.has(locale):
		push_warning("LocaleManager: unsupported locale '%s', ignoring." % locale)
		return
	if locale == current_locale:
		return
	current_locale = locale
	TranslationServer.set_locale(locale)
	_save_locale()
	locale_changed.emit(current_locale)


func cycle_locale() -> void:
	var index: int = SUPPORTED_LOCALES.find(current_locale)
	var next_index: int = (index + 1) % SUPPORTED_LOCALES.size()
	set_locale(SUPPORTED_LOCALES[next_index])


func _load_saved_locale() -> void:
	var config := ConfigFile.new()
	var locale: String = DEFAULT_LOCALE
	if config.load(SETTINGS_PATH) == OK:
		locale = config.get_value(SETTINGS_SECTION, SETTINGS_KEY, DEFAULT_LOCALE)
	if not SUPPORTED_LOCALES.has(locale):
		locale = DEFAULT_LOCALE
	current_locale = locale
	TranslationServer.set_locale(locale)


func _save_locale() -> void:
	var config := ConfigFile.new()
	config.load(SETTINGS_PATH)
	config.set_value(SETTINGS_SECTION, SETTINGS_KEY, current_locale)
	config.save(SETTINGS_PATH)
