extends Node

var game_loaded = false
var paused = false

var settings_def = {
    "example_toggle": {
        "name": "Example Toggle",
        "main_menu_only": true,#optional
        "type": "toggle",
        "default": false
    },
    "example_number": {
        "name": "Example Number",
        "type": "number",
        "default": 0,
        "min": 1,
        "max": 100000000,
        "step": 1#optional
    },
    "example_choice": {
        "name": "Example Dropdown",
        "type": "choice",
        "default": 0,
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

