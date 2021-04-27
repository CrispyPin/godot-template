extends Control

export var instant_start = false
export var game_scene = preload("res://scenes/Game.tscn")

func _ready():
    menu_main()
    if instant_start:
        call_deferred("start_game")

func _process(_delta):
    if Input.is_key_pressed(KEY_F5):
        start_game()

func start_game():
    if Settings.game_loaded:
        return
    Settings.game_loaded = true
    var game = game_scene.instance()
    get_tree().root.add_child_below_node(Settings, game)
    menu_close()

func menu_main():
    menu_close()
    $MainMenu.show()

func menu_game():
    menu_close()
    $GameMenu.show()

func menu_settings():
    menu_close()
    $SettingsMenu.show()

func menu_info():
    menu_close()
    $InfoMenu.show()

func menu_close():
    for menu in get_children():
        menu.visible = false
