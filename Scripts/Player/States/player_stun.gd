class_name PlayerStun extends State

var entity : CharacterBody2D

var _animation_finished : bool = false

@export var decelerate_speed : float = 2.5
@export var invulnerable_duration : float = 1.0

func Enter():
	_animation_finished = false
	entity.make_invulnerable(invulnerable_duration)
	entity._update_animation("Stun")
	entity.anim.animation_finished.connect( _on_animation_finished )
	pass

func Exit():
	entity.anim.animation_finished.disconnect (_on_animation_finished )
	pass

func Update(delta: float):
	if _animation_finished == true:
		Transitioned.emit(self, "PlayerMovement")
	entity.velocity.x -= entity.velocity.x * decelerate_speed * delta

func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
