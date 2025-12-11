extends Node

const PLAYER = preload("res://Scenes/player/player.tscn")

var player : Player
var player_spawned : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	get_tree().current_scene.add_child(player)

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
