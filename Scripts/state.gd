@icon("res://Assets/Sprites/state.svg")
class_name State extends Node

signal Transitioned

#What happens when we initialize this state?
func Init() -> void:
	pass

#What happens when we enter this state?
func Enter() -> void:
	pass

#What happens when we exit this state?
func Exit() -> void:
	pass

#Process function when active
func Update(_delta : float) -> void:
	pass

#Physics process function when active
func Physics_Update(_delta : float) -> void:
	pass

#Handle unhandled inputs when active
func Handle_Input(_event : InputEvent) -> void:
	pass
