class_name PlayerDeath extends State

var entity : CharacterBody2D

var _animation_finished : bool = false
#var damage_position : Vector2
#var direction : Vector2

#@export var decelerate_speed : float = 2.5
#@export var knockback_speed : float = 60.0
#@export var invulnerable_duration : float = 1.0

func Init():
	#entity._damaged.connect(player_damaged)
	pass

func Enter():
	#entity.anim.animation_finished.connect( _on_animation_finished )
	
	#direction = entity.global_position.direction_to(damage_position)
	#entity.velocity = direction * -knockback_speed
	#entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	
	#_animation_finished = false
	#entity.make_invulnerable(invulnerable_duration)
	
	entity._update_animation("Dead")
	PlayerHud.show_game_over_screen()
	pass

func Exit():
	#entity.anim.animation_finished.disconnect (_on_animation_finished )
	pass

func Update(delta: float):
	#if _animation_finished == true:
		#Transitioned.emit(self, "PlayerMovement")
	pass

func Physics_Update(delta: float):
	#entity.velocity.x -= entity.velocity.x * decelerate_speed * delta
	if not entity.is_on_floor():
		entity.velocity.y += entity.gravity * delta
	else:
		entity.velocity.x = 0.0

#func player_damaged( hit_box : HitBox ) -> void:
	#damage_position = hit_box.global_position
	#Transitioned.emit(self, "PlayerStun")

func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
