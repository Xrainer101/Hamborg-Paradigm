class_name EnemyDeath extends State

var entity : CharacterBody2D

var _animation_finished : bool = false
var damage_position : Vector2
var direction : Vector2

@export var decelerate_speed : float = 2.5
@export var knockback_speed : float = 30.0
@export var invulnerable_duration : float = 1.0

func Init():
	entity._death.connect(enemy_death)

func Enter():
	entity.anim.animation_finished.connect( _on_animation_finished )
	
	entity.invulnerable = true
	
	direction = entity.global_position.direction_to(damage_position)
	entity.velocity = direction * -knockback_speed
	entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	
	entity._update_animation("Death")
	disable_hit_box()
	
	pass

func Exit():
	pass

func Update(delta : float):
	pass

func Physics_Update(delta : float):
	entity.velocity.x -= entity.velocity.x * decelerate_speed * delta

func enemy_death(hit_box : HitBox) -> void:
	damage_position = hit_box.global_position
	Transitioned.emit(self, "EnemyDeath")

func _on_animation_finished(_a : String) -> void:
	entity.queue_free()

func disable_hit_box() -> void:
	var hit_box : HitBox = entity.get_node_or_null("HitBox")
	if hit_box:
		hit_box.monitoring = false
