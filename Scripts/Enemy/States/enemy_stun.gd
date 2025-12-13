class_name EnemyStun extends State

var entity : CharacterBody2D

var _animation_finished : bool = false
var damage_position : Vector2
var direction : Vector2

@export var decelerate_speed : float = 2.5
@export var knockback_speed : float = 30.0
@export var invulnerable_duration : float = 1.0

func Init():
	entity._damaged.connect(enemy_damaged)

func Enter():
	entity.anim.animation_finished.connect( _on_animation_finished )
	
	entity.invulnerable = true
	_animation_finished = false
	
	direction = entity.global_position.direction_to(damage_position)
	entity.velocity = direction * -knockback_speed
	entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	
	entity._update_animation("Stun")
	
	pass

func Exit():
	entity.invulnerable = false
	entity.anim.animation_finished.disconnect (_on_animation_finished )
	pass

func Update(delta : float):
	if _animation_finished == true:
		Transitioned.emit(self, "EnemyFollow")

func Physics_Update(delta : float):
	entity.velocity.x -= entity.velocity.x * decelerate_speed * delta

func enemy_damaged( hit_box : HitBox ) -> void:
	if entity.super_armor == false:
		damage_position = hit_box.global_position
		Transitioned.emit(self, "EnemyStun")

func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
