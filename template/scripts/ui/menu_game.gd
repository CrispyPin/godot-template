extends Control

export var pause_game = true
export var exit_quits_game = false


func _on_ResumeButton_pressed() -> void:
    UI.menu_close()


func _on_SettingsButton_pressed() -> void:
    UI.menu_settings()


func _on_ExitButton_pressed() -> void:
    if exit_quits_game:
        get_tree().quit()
    else:
        UI.stop_game()
