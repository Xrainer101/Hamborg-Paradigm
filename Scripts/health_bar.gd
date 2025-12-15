extends TextureProgressBar

@export var entity : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(entity == null):
		entity = PlayerManager.player
	max_value = entity.max_hp
	pass # Replace with function body.

func _process(delta: float) -> void:
	if entity:
		value = entity.hp

func update_hp(hp : int, max_hp : int) -> void:
	max_value = max_hp
	value = hp
