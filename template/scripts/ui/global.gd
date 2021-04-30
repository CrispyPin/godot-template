extends Node

var game_loaded = false
var settings_loaded = false
var paused = false

const debug_settings = false

const settings_filepath = "user://settings.json"
const settings_def = {
    "example_toggle": {
        "name": "Toggle (main menu)",
        "main_menu_only": true,#optional
        "type": "toggle",
        "default": false
    },
    "example_number": {
        "name": "Number setting",
        "type": "number",
        "default": 420,
        "min": 1,
        "max": 10000,
        "step": 1#optional
    },
    "example_choice": {
        "name": "Dropdown: ",
        "type": "choice",
        "default": 1,
        "options": ["Option A", "Option B", "Option C"]
    }
}

var settings = {}

func _ready() -> void:
    init_settings()
    load_settings()
    settings_loaded = true
    get_node("/root/Default").queue_free()

func set_setting(key, val):
    settings[key] = val
    if debug_settings:
        print("Settings changed. ", key, ": ", val)
    save_settings()

func init_settings():
    for key in settings_def:
        settings[key] = settings_def[key].default
    if debug_settings:
        print("Default settings: ", settings)

func save_settings():
    var file = File.new()
    file.open(settings_filepath, File.WRITE)
    file.store_line(to_json(settings))
    file.close()

func load_settings():
    var file = File.new()

    if not file.file_exists(settings_filepath):
        if debug_settings:
            print("No settings file exists, using defaults")
        return

    file.open(settings_filepath, File.READ)
    var new_settings = parse_json(file.get_as_text())
    file.close()

    # in case settings format has changed, this is better than just copying
    for key in new_settings:
        if settings.has(key):
            settings[key] = new_settings[key]
    save_settings()
    if debug_settings:
        print("Loaded settings from file")
        print(settings)
