extends Control

func _on_PlayButton_pressed():
    UI.start_game()

func _on_SettingsButton_pressed():
    UI.menu_settings()

func _on_ExitButton_pressed():
    get_tree().quit()

func _on_InfoButton_pressed():
    UI.menu_info()
