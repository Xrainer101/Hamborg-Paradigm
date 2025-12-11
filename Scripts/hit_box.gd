class_name HitBox extends Area2D

@export var damage : int = 1
@export var _player : Player
var _knockback_speed : float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func AreaEntered(a : Area2D) -> void:
	if a is HurtBox:
		a.TakeDamage( self )
		if _player:
			_player.velocity.x = _player.sprite.scale.x * -_knockback_speed
