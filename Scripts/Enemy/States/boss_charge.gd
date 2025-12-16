class_name BossCharge extends State

@export var chase_speed : int = 100.0
# @export var knockback_speed : float = 20.0
@onready var wall_ray_cast: RayCast2D = $"../../Sprite2D/WallRayCast2D"

var entity : CharacterBody2D
var player : Player

var distance : Vector2
var direction : float = distance.normalized().x

func Init():
	# entity._damaged.connect(enemy_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	player = PlayerManager.player
	distance = player.global_position - entity.global_position
	direction = distance.normalized().x
	
	entity._update_animation("Walk")
	entity.velocity.x = direction * chase_speed
	
	entity.super_armor = true
	
	pass

func Exit():
	entity.super_armor = false

func Update(delta : float):
	if wall_ray_cast.is_colliding():
		Transitioned.emit(self, "EnemyIdle")

func Physics_Update(delta : float):
	pass

# func enemy_damaged( hit_box : HitBox ) -> void:
	# print("Changing from chase to stun")
	# var direction : float = entity.global_position.direction_to(hit_box.global_position).x
	# entity.velocity.y = 0.0
	# entity.velocity.x = direction * -knockback_speed
	# Transitioned.emit(self, "EnemyStun")
