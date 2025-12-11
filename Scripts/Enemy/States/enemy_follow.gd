class_name EnemyFollow extends State

@export var chase_speed : int = 20.0
@export var knockback_speed : float = 20.0
var entity : CharacterBody2D
var player : CharacterBody2D

func Init():
	entity._damaged.connect(enemy_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(delta : float):
	if entity.velocity.x == 0:
		entity._update_animation("Idle")
	elif entity.velocity.x != 0:
		entity._update_animation("Walk")

func Physics_Update(delta : float):
	var distance : Vector2 = player.global_position - entity.global_position
	var direction : float = distance.normalized().x
	
	#if distance.length() > 25:
	entity.velocity.x = direction * chase_speed
	#else:
		#entity.velocity.x = 0.0
	
	if distance.length() > 100:
		Transitioned.emit(self, "EnemyIdle")

func enemy_damaged( hit_box : HitBox ) -> void:
	print("Changing from chase to stun")
	var direction : float = entity.global_position.direction_to(hit_box.global_position).x
	entity.velocity.y = 0.0
	entity.velocity.x = direction * -knockback_speed
	Transitioned.emit(self, "EnemyStun")
