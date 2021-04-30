extends MenuButton

onready var popup = get_popup()

func _ready() -> void:
    popup.connect("id_pressed", self, "_on_item_pressed")
    popup.submenu_popup_delay = 0
    print(popup.items)

func _on_item_pressed(id):
    var state = get_popup().is_item_checked(id)
    get_popup().set_item_checked(id, !state)

    print(id)
