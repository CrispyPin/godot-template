extends MenuButton

signal on_selection_changed

export var base_name = ""

onready var popup = get_popup()

func _ready() -> void:
    popup.connect("id_pressed", self, "_on_item_pressed")
    popup.submenu_popup_delay = 0

func _on_item_pressed(id):
    for i in popup.get_item_count():
        popup.set_item_checked(i, i==id)
    text = base_name + ": " + popup.get_item_text(id)
    emit_signal("on_selection_changed", id)
