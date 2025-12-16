class_name EnemyIdle extends State

@export var max_move_speed : int = 10
# @export var knockback_speed : float = 30.0
var move_speed : int = max_move_speed
var entity : CharacterBody2D
@onready var wall_ray_cast: RayCast2D = $"../../Sprite2D/RayCast2D"

var move_direction : int
var wander_time : float

var player : Player

#What happens when we initialize this state?
func Init():
	# entity._damaged.connect(enemy_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	player = PlayerManager.player
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	
	if entity.velocity.x == 0:
		entity._update_animation("Idle")
	elif entity.velocity.x != 0:
		entity._update_animation("Walk")

func Physics_Update(delta: float):
	if(wall_ray_cast.is_colliding()):
		move_direction *= -1
	if entity:
		entity.velocity.x = move_direction * move_speed
	
	var distance_to_player : Vector2 = player.global_position - entity.global_position
	if distance_to_player.length() < 80:
		Transitioned.emit(self, "EnemyFollow")

func randomize_wander():
	move_direction = randi_range(-1, 1)
	wander_time = randf_range(1, 3)
	move_speed = randi_range(0, max_move_speed)

# func enemy_damaged( hit_box : HitBox ) -> void:
	# var direction : float = entity.global_position.direction_to(hit_box.global_position).x
	# entity.velocity.y = 0.0
	# entity.velocity.x = direction * -knockback_speed
	# Transitioned.emit(self, "EnemyStun")
