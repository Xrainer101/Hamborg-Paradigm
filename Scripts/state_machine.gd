extends Node

@export var _entity : CharacterBody2D
@export var initial_state : State
var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			if _entity:
				child.entity = _entity
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state: State, new_state_name: String):
	# if the state calling the transition is not the current state, stop
	if state != current_state:
		return
	
	# Get the new state and see if it exists
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	# Exit if we have a current state
	if current_state:
		current_state.Exit()
	
	#Enter the new state
	new_state.Enter()
	
	#Update the current state
	current_state = new_state
	
