extends CanvasLayer

@export var button_focus_audio : AudioStream = preload("res://Assets/SFX/menu_focus.wav")
@export var button_select_audio : AudioStream = preload("res://Assets/SFX/menu_select.wav")

@onready var game_over: Control = $Control/GameOver
@onready var retry_button: Button = $Control/GameOver/VBoxContainer/RetryButton
@onready var animation_player: AnimationPlayer = $Control/GameOver/AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hide_game_over_screen()
	
	retry_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	retry_button.pressed.connect( load_game )
	
	LevelManager.level_load_started.connect( hide_game_over_screen )
	pass # Replace with function body.

func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
	
	retry_button.grab_focus()

func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1,1,1,0)

func load_game() -> void:
	play_audio( button_select_audio )
	await fade_to_black()
	PlayerManager.player.reset_player()
	LevelManager.load_new_level("res://Scenes/levels/level_1.tscn", "", Vector2.ZERO)

func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.reset_player()
	return true

func play_audio (_a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
