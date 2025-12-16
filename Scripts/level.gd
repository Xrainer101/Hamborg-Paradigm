class_name Level extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(PlayerManager.player)
	LevelManager.level_load_started.connect(_free_level)
	pass # Replace with function body.


func _free_level() -> void:
	remove_child(PlayerManager.player)
	queue_free()
