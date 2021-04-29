extends Control

func _on_BackButton_pressed() -> void:
    if Settings.game_loaded:
        UI.set_menu("Game")
    else:
        UI.set_menu("Main")
