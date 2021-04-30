extends Node

var game_loaded = false
var paused = false

var settings_def = {
    "example_toggle": {
        "name": "A Toggle",
        "main_menu_only": true,#optional
        "type": "toggle",
        "default": false
    },
    "example_number": {
        "name": "A Number",
        "type": "number",
        "default": 420,
        "min": 1,
        "max": 10000,
        "step": 1#optional
    },
    "example_choice": {
        "name": "A Dropdown",
        "type": "choice",
        "default": 1,
        "options": ["Option A", "Option B", "Option C"]
    }
}

var settings = {}

func _ready() -> void:
    for key in settings_def:
        var setting = settings_def[key]
        settings[key] = setting.default
    print(settings)

    get_node("/root/Default").queue_free()

