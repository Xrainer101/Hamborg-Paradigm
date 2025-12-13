extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func update_hp(hp : int, max_hp : int) -> void:
	max_value = max_hp
	value = hp
