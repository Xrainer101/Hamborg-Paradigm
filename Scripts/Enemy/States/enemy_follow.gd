class_name EnemyFollow extends State

@export var chase_speed : int = 20.0
var entity : CharacterBody2D
var player : CharacterBody2D

@onready var anim: AnimationPlayer = $"../../AnimationPlayer"

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(delta : float):
	if entity.velocity.x == 0:
		anim.play("Idle")
	elif entity.velocity.x != 0:
		anim.play("Walk")

func Physics_Update(delta : float):
	var distance : Vector2 = player.global_position - entity.global_position
	var direction : float = distance.normalized().x
	
	if distance.length() > 25:
		entity.velocity.x = direction * chase_speed
	else:
		entity.velocity.x = 0.0
	
	if distance.length() > 100:
		Transitioned.emit(self, "EnemyIdle")
