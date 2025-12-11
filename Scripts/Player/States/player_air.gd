class_name PlayerAir extends State

var entity: CharacterBody2D

@export var speed : float = 150.0
@export var air_acceleration: float = 50.0
# @export var knockback_speed : float = 60.0
@export var jump_velocity: float = -350.0

func Init():
	# entity._damaged.connect(player_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	entity._update_animation("Jump")

func Physics_Update(delta: float):
	# Should later make gravity stronger when going down
	if not entity.is_on_floor():
		entity.velocity.y += entity.gravity * delta
	
	#Short hop
	if Input.is_action_just_released("jump") and entity.velocity.y < 0:
		entity.velocity.y /= 2
	
	# Handle air movement
	if entity.direction > 0:
		entity.sprite.scale.x = 1
	elif entity.direction < 0:
		entity.sprite.scale.x = -1

	entity.velocity.x = clampf(entity.velocity.x + (entity.direction * air_acceleration), -speed, speed)
	
	if entity.is_on_floor():
		Transitioned.emit(self, "PlayerMovement")

func Handle_Input(_event : InputEvent):
	if Input.is_action_pressed("attack"):
		#print("Player attacked")
		Transitioned.emit(self, "PlayerAirAttack")

# func player_damaged( hit_box : HitBox ) -> void:
	# var direction: Vector2 = entity.global_position.direction_to(hit_box.global_position)
	# entity.velocity = direction * -knockback_speed
	# entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	# Transitioned.emit(self, "PlayerStun")
