class_name PlayerGroundAttack extends State

var entity : CharacterBody2D

var attacking : bool = false

@onready var sword_hit_box: HitBox = $"../../Sprite2D/Sword/HitBox"
@export_range(1,20,0.5) var decelerate_speed : float = 5.0
@export var knockback_speed : float = 30.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func Init():
	entity._damaged.connect(player_damaged)
	# entity.death.connect(_death)
	pass

func Enter():
	print("Enter attack state")
	entity._update_animation("Sword")
	
	entity.anim.animation_finished.connect(EndAttack)
	
	attacking = true
	
	#await get_tree().create_timer(0.075).timeout
	#if attacking:
		#sword_hit_box.monitoring = true
	pass

func Exit():
	entity.anim.animation_finished.disconnect(EndAttack)
	attacking = false
	sword_hit_box.monitoring = false
	pass

func Update(delta : float):
	if not entity.is_on_floor():
		entity.velocity.y += gravity * delta
	
	entity.velocity.x -= entity.velocity.x * decelerate_speed * delta
	
	if attacking == false:
		Transitioned.emit(self, "PlayerMovement")

func player_damaged( hit_box : HitBox ) -> void:
	var direction: float = entity.global_position.direction_to(hit_box.global_position).x
	entity.velocity.y = 0.0
	entity.velocity.x = direction * -knockback_speed
	Transitioned.emit(self, "PlayerStun")

func EndAttack( _newAnimName : String) -> void:
	attacking = false
