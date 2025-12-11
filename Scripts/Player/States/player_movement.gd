class_name PlayerMovement extends State

var entity: CharacterBody2D

@export var speed : float = 150.0
# @export var knockback_speed : float = 60.0
@export var jump_velocity: float = -350.0

func Init():
	# entity._damaged.connect(player_damaged)
	# entity.death.connect(_death)
	pass

func Physics_Update(delta: float):
	#Make sure entity is on the ground
	if not entity.is_on_floor():
		Transitioned.emit(self, "PlayerAir")
	
	if entity.direction > 0:
		entity.sprite.scale.x = 1
	elif entity.direction < 0:
		entity.sprite.scale.x = -1
	
	if entity.direction == 0:
		entity._update_animation("Idle")
	else:
		entity._update_animation("Walk")
	
	if entity.direction:
		entity.velocity.x = entity.direction * speed
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, speed)

func Handle_Input(_event : InputEvent):
	#Handle jump
	if Input.is_action_just_pressed("jump") and entity.is_on_floor():
		#print("Enter jump state")
		entity.velocity.y = jump_velocity
		# Transitioned.emit(self, "PlayerAir")
	#Handle attack
	elif Input.is_action_pressed("attack"):
		#print("Player attacked")
		Transitioned.emit(self, "PlayerGroundAttack")

# func player_damaged( hit_box : HitBox ) -> void:
	# var direction: Vector2 = entity.global_position.direction_to(hit_box.global_position)
	# entity.velocity = direction * -knockback_speed
	# entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	# Transitioned.emit(self, "PlayerStun")
