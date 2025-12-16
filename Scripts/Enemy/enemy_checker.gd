extends Node2D

@export_file("*.tscn") var level
@export var final_level : bool = false
@export var target_transition_area : String = "LevelTransition"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!has_enemies()):
		if(final_level):
			get_tree().paused = true
			PlayerHud.show_win_screen()
		else:
			LevelManager.load_new_level("res://Scenes/levels/upgrade_station.tscn", "", Vector2.ZERO)

func has_enemies() -> bool:
	for child in get_children():
		if is_instance_of(child, Enemy):
			return true
	return false
