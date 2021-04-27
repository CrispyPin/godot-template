extends Node

export var instant_start = false
export var game_scene = preload("res://scenes/Game.tscn")

func _ready():
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
    get_tree().root.add_child(game)
