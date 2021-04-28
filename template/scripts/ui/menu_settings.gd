extends Control



func _on_BackButton_pressed() -> void:
    if Settings.game_loaded:
        UI.menu_game()
    else:
        UI.menu_main()
