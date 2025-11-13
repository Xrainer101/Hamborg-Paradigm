class_name EnemyIdle extends State

@onready var anim: AnimationPlayer = $"../../AnimationPlayer"

@export var max_move_speed : int = 10
var move_speed : int = max_move_speed
var entity : CharacterBody2D

var move_direction : int
var wander_time : float

var player : CharacterBody2D

func randomize_wander():
	move_direction = randi_range(-1, 1)
	wander_time = randf_range(1, 3)
	move_speed = randi_range(0, max_move_speed)

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	
	if entity.velocity.x == 0:
		anim.play("Idle")
	elif entity.velocity.x != 0:
		anim.play("Walk")

func Physics_Update(delta: float):
	if entity:
		entity.velocity.x = move_direction * move_speed
	
	var distance_to_player : Vector2 = player.global_position - entity.global_position
	if distance_to_player.length() < 80:
		Transitioned.emit(self, "EnemyFollow")
