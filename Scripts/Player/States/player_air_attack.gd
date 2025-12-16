class_name PlayerAirAttack extends State

var entity : CharacterBody2D

var attacking : bool = false

@onready var sword_hit_box: HitBox = $"../../Sprite2D/Sword/HitBox"
@export var speed : float = 150.0
@export var air_acceleration: float = 50.0
@export_range(1,20,0.5) var decelerate_speed : float = 5.0
# @export var knockback_speed : float = 60.0
@export var slash_sound : AudioStream

func Init():
	# entity._damaged.connect(player_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	#print("Enter air attack state")
	entity.attack_audio.pitch_scale = randf_range(0.9, 1.1)
	entity.attack_audio.stream = slash_sound
	entity.attack_audio.play()
	entity._update_animation("Sword")
	
	entity.anim.animation_finished.connect(EndAttack)
	
	attacking = true
	
	#await get_tree().create_timer(0.075).timeout
	#if attacking:
		#sword_hit_box.monitoring = true
	pass

func Exit():
	entity.anim.animation_finished.disconnect(EndAttack)
	# entity.audio.pitch_scale = 1.0
	attacking = false
	sword_hit_box.monitoring = false
	pass

func Update(delta : float):
	if attacking == false:
		if entity.is_on_floor():
			Transitioned.emit(self, "PlayerMovement")
		else:
			Transitioned.emit(self, "PlayerAir")

func Physics_Update(delta : float):
	if not entity.is_on_floor():
		entity.velocity.y += entity.gravity * delta
		entity.velocity.x = clampf(entity.velocity.x + (entity.direction * air_acceleration), -speed, speed)
	else:
		entity.velocity.x -= entity.velocity.x * decelerate_speed * delta

# func player_damaged( hit_box : HitBox ) -> void:
	# var direction: Vector2 = entity.global_position.direction_to(hit_box.global_position)
	# entity.velocity = direction * -knockback_speed
	# entity.velocity.y = clampf(entity.velocity.y, entity.velocity.y, 0.0)
	# Transitioned.emit(self, "PlayerStun")

func EndAttack( _newAnimName : String) -> void:
	attacking = false
