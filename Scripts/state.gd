@icon("res://Assets/Sprites/state.svg")
class_name State extends Node

signal Transitioned

#What happens when we initialize this state?
func init() -> void:
	pass

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float) -> void:
	pass
