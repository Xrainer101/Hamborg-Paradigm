class_name Player extends CharacterBody2D

@export var max_hp : int = 8
var hp : int = max_hp
var invulnerable : bool = false
var super_armor : bool = false
var direction : float

var upgrades : Array[int]

@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var attack_audio: AudioStreamPlayer2D = $Audio/AttackStreamPlayer2D
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite: Sprite2D = $Sprite2D

signal _damaged( hit_box : HitBox )
#signal _death( hit_box : HitBox )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_box.Damaged.connect( _take_damage )
	LevelManager.level_loaded.connect(_stop_player)
	$CollisionShape2D.disabled = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Input.get_axis("walk_left", "walk_right")
	pass

func _physics_process(delta) -> void:
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# if event.is_action_pressed("test"):
		# update_hp(-99)
		# _damaged.emit( $Sprite2D/Sword/HitBox )
	pass

func _update_animation(anim_name : String) -> void:
	anim.play(anim_name)

func _take_damage(hit_box : HitBox) -> void:
	if invulnerable == true:
		return
	if hp > 0:
		update_hp(-hit_box.damage)
		_damaged.emit( hit_box )

func update_hp(delta : int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	# PlayerHud.update_hp(hp, max_hp)
	pass

func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hurt_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hurt_box.monitoring = true
	pass

func _stop_player() -> void:
	velocity = Vector2.ZERO

func reset_player() -> void:
	PlayerManager.player_spawned = false
	PlayerManager.add_player_instance()
	queue_free()
