class_name Enemy extends CharacterBody2D

@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var max_hp: int = 3
var hp : int
var invulnerable : bool = false
var super_armor : bool = false

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt_box: HurtBox = $HurtBox

signal _damaged( hit_box : HitBox )
signal _death( hit_box : HitBox )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = max_hp
	hurt_box.Damaged.connect( _take_damage )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(velocity.x > 0):
		sprite.scale.x = 1
	elif(velocity.x < 0):
		sprite.scale.x = -1
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func _update_animation(anim_name : String) -> void:
	anim.play(anim_name)

func _take_damage(hit_box : HitBox) -> void:
	# print("Enemy's taking damage")
	if invulnerable == true:
		# print("Enemy's invulnerable")
		return
	hp -= hit_box.damage
	if hp > 0:
		# print("Enemy's emitting _damaged")
		_damaged.emit( hit_box )
	else:
		_death.emit( hit_box)
