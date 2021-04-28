extends Control

export var instant_start = false
export var game_scene = preload("res://scenes/Game.tscn")

enum {MENU_CLOSED, MENU_MAIN, MENU_GAME, MENU_SETTINGS, MENU_INFO}
var curren_menu = MENU_MAIN

func _ready():
    menu_main()
    if instant_start:
        call_deferred("start_game")

func _process(_delta):
    if Input.is_key_pressed(KEY_F5):
        start_game()

    if Input.is_action_just_pressed("game_menu") and Settings.game_loaded:
        if curren_menu == MENU_CLOSED:
            menu_game()
        elif curren_menu == MENU_GAME:
            menu_close()

func start_game():
    if Settings.game_loaded:
        return
    Settings.game_loaded = true
    var game = game_scene.instance()
    get_tree().root.add_child_below_node(Settings, game)
    menu_close()

func stop_game():
    if !Settings.game_loaded:
        return
    Settings.game_loaded = false
    get_node("/root/Game").queue_free()
    menu_main()

func menu_main():
    menu_close()
    $MainMenu.show()
    curren_menu = MENU_MAIN

func menu_game():
    menu_close()
    $GameMenu.show()
    curren_menu = MENU_GAME

func menu_settings():
    menu_close()
    $SettingsMenu.show()
    curren_menu = MENU_SETTINGS

func menu_info():
    menu_close()
    $InfoMenu.show()
    curren_menu = MENU_INFO

func menu_close():
    for menu in get_children():
        menu.visible = false
    curren_menu = MENU_CLOSED
