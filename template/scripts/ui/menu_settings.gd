extends Control

export var toggle_setting = preload("res://scenes/ui/menu_items/ButtonToggle.tscn")
export var number_setting = preload("res://scenes/ui/menu_items/NumberSetting.tscn")
export var dropdown_setting = preload("res://scenes/ui/menu_items/DropdownSetting.tscn")

var container
var container_title
var main_menu_only = []

func _ready() -> void:
    container = $PanelContainer/MarginContainer/VBoxContainer
    container_title = container.get_child(0)
    _generate_menu()

func _generate_menu():
    for s_key in Global.settings_def:
        var s_prop = Global.settings_def[s_key]
        var new_item

        if s_prop.type == "toggle":
            new_item = _add_toggle(s_key, s_prop)
        elif s_prop.type == "number":
            new_item = _add_number(s_key, s_prop)
        elif s_prop.type == "choice":
            new_item = _add_option(s_key, s_prop)

        if s_prop.has("main_menu_only") and s_prop.main_menu_only:
            main_menu_only.append(new_item)

        container.add_child_below_node(container_title, new_item)

func _add_toggle(name, properties):
    var item = toggle_setting.instance()
    var btn = item.get_child(0)
    btn.connect("pressed", self, "_on_toggle_changed", [name])

    item.name = name
    btn.text = properties.name
    btn.pressed = properties.default
    return item

func _add_number(name, properties):
    var item = number_setting.instance()
    var spinbox = item.get_child(0).get_child(1)
    spinbox.connect("value_changed", self, "_on_number_changed", [name])

    item.name = name
    spinbox.min_value = properties.min
    spinbox.max_value = properties.max
    spinbox.value = properties.default
    spinbox.step = properties.step
    item.get_child(0).get_child(0).get_child(0).text = properties.name
    return item

func _add_option(name, properties):
    var item = dropdown_setting.instance()
    return item

func _on_toggle_changed(name):
    var state = container.get_node(name).get_child(0).pressed
    Global.settings[name] = state
    print(name, ": ", state)

func _on_number_changed(val, name):
    Global.settings[name] = val
    print(name, ": ", val)






func _on_BackButton_pressed() -> void:
    if Global.game_loaded:
        UI.set_menu("Game")
    else:
        UI.set_menu("Main")
