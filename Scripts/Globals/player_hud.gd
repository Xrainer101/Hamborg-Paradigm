extends CanvasLayer

@export var button_focus_audio : AudioStream = preload("res://Assets/SFX/menu_focus.wav")
@export var button_select_audio : AudioStream = preload("res://Assets/SFX/menu_select.wav")

@onready var health_bar: TextureProgressBar = $Control/HealthBar

@onready var game_over: Control = $Control/GameOver
@onready var retry_button: Button = $Control/GameOver/VBoxContainer/RetryButton

@onready var win_screen: Control = $Control/WinScreen
@onready var replay_button: Button = $Control/WinScreen/VBoxContainer/ReplayButton

@onready var black_rect: ColorRect = $Control/FadeToBlack

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hide_game_over_screen()
	hide_win_screen()
	hide_fade_to_black()
	
	retry_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	retry_button.pressed.connect( load_game )
	
	replay_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	replay_button.pressed.connect( load_game )
	
	LevelManager.level_load_started.connect( hide_game_over_screen )
	LevelManager.level_load_started.connect( hide_win_screen )
	LevelManager.level_load_started.connect( hide_fade_to_black )
	
	pass # Replace with function body.

# func update_hp(hp : int, max_hp : int):
	# health_bar.update_hp(hp, max_hp)

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

func hide_fade_to_black() -> void:
	black_rect.visible = false

func show_win_screen() -> void:
	win_screen.visible = true
	win_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	
	animation_player.play("show_win_screen")
	await animation_player.animation_finished
	
	replay_button.grab_focus()

func hide_win_screen() -> void:
	win_screen.visible = false
	win_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	win_screen.modulate = Color(1,1,1,0)


func load_game() -> void:
	play_audio( button_select_audio )
	await fade_to_black()
	PlayerManager.player.reset_player()
	health_bar.entity = PlayerManager.player
	LevelManager.load_new_level("res://Scenes/levels/level_1.tscn", "", Vector2.ZERO)
	LevelManager.curr_level = 0

func fade_to_black() -> bool:
	black_rect.visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	PlayerManager.player.reset_player()
	return true

func play_audio (_a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
