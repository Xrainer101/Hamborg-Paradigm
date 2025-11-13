class_name PlayerMovement extends State

var entity: CharacterBody2D

var direction: float
@export var speed: float = 200.0
@export var knockback_speed : float = 30.0
@export var jump_velocity: float = -350.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: Sprite2D = $"../../Sprite2D"

func init() -> void:
	entity._damaged.connect(player_damaged)
	# entity.death.connect(_death)
	pass

func Physics_Update(delta: float):
	if not entity.is_on_floor():
		entity.velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and entity.is_on_floor():
		entity.velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump") and entity.velocity.y < 0:
		entity.velocity.y /= 2
	
	direction = Input.get_axis("walk_left", "walk_right")
	
	if direction > 0:
		sprite.scale.x = 1
	elif direction < 0:
		sprite.scale.x = -1
	
	if direction == 0:
		entity.anim.play("Idle")
	else:
		entity.anim.play("Walk")
	
	if direction:
		entity.velocity.x = direction * speed
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, speed)

func player_damaged( hit_box : HitBox ) -> void:
	direction = entity.global_position.direction_to(hit_box.global_position).x
	entity.velocity.y = 0.0
	entity.velocity.x = direction * -knockback_speed
	Transitioned.emit(self, "PlayerStun")
