extends Node

signal level_load_started
signal level_loaded

const LEVEL_2 : String = "res://Scenes/levels/level_2.tscn"
const LEVEL_3 : String = "res://Scenes/levels/level_3.tscn"
const BOSS_LEVEL : String = "res://Scenes/levels/boss_level.tscn"

var target_transition : String
var position_offset : Vector2
var curr_level : int = 0

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()

func load_new_level(
	level_path : String,
	_target_transition : String,
	_position_offset : Vector2
) -> void:
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in()
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	
	pass
