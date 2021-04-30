extends Control

export var toggle_setting = preload("res://scenes/ui/menu_items/ButtonToggle.tscn")
export var number_setting = preload("res://scenes/ui/menu_items/NumberSetting.tscn")
export var dropdown_setting = preload("res://scenes/ui/menu_items/DropdownSetting.tscn")

onready var container = get_node("PanelContainer/MarginContainer/VBoxContainer")
onready var container_title = container.get_child(0)
var main_menu_only = []
var has_initialised = false

func _process(_delta) -> void:
    if Global.settings_loaded and !has_initialised:
        create_menu()
        has_initialised = true

func update_menu():
    for i in container.get_children():
        if i in main_menu_only:
            i.visible = !Global.game_loaded

func create_menu():
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

        container.add_child_below_node(container.get_children()[-2], new_item)


func _add_toggle(name, properties):
    var item = toggle_setting.instance()
    var btn = item.get_child(0)
    btn.connect("pressed", self, "_on_toggle_changed", [name])

    item.name = name
    btn.text = properties.name
    btn.pressed = Global.settings[name]
    return item

func _add_number(name, properties):
    var item = number_setting.instance()
    var spinbox = item.get_child(0).get_child(1)
    spinbox.connect("value_changed", self, "_on_number_changed", [name])

    item.name = name
    spinbox.min_value = properties.min
    spinbox.max_value = properties.max
    spinbox.value = Global.settings[name]
    if properties.has("step"):
        spinbox.step = properties.step
    item.get_child(0).get_child(0).get_child(0).text = properties.name
    return item

func _add_option(name, properties):
    var item = dropdown_setting.instance()
    var btn = item.get_child(0)
    btn.connect("item_selected", self, "_on_option_changed", [name])

    for i in properties.options:
        btn.add_item(properties.name + i)
    btn.selected = Global.settings[name]

    item.name = name
    return item

func _on_toggle_changed(name):
    var state = container.get_node(name).get_child(0).pressed
    Global.set_setting(name, state)

func _on_number_changed(val, name):
    Global.set_setting(name, val)

func _on_option_changed(val, name):
    Global.set_setting(name, val)


func _on_BackButton_pressed() -> void:
    if Global.game_loaded:
        UI.set_menu("Game")
    else:
        UI.set_menu("Main")
