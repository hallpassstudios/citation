extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

var faded
var correct_count = 0
var sound_played = false
onready var hud = $HUD

var word_1 : Vector2
var word_2 : Vector2
var word_3 : Vector2
var word_4 : Vector2
var word_5 : Vector2
var word_6 : Vector2

var word_1_correct : bool
var word_2_correct : bool
var word_3_correct : bool

var should_reset : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# dialogue_controller.play_dialogue("cellar")
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position
	# tell our player what the current scene is
	globals.current_scene = self
	$"torch zone".visible = false
	$"torch zone".monitoring = false
	
	# set our word positions
	word_1 = $"word puzzle/word 1".position
	word_2 = $"word puzzle/word 2".position
	word_3 = $"word puzzle/word 3".position
	word_4 = $"word puzzle/word 4".position
	word_5 = $"word puzzle/word 5".position
	word_6 = $"word puzzle/word 6".position

func restart(title, subtitle):
	hud.restart(title,subtitle)

func _process(delta):	
	if correct_count == 3 && !sound_played:
		$"torch zone".visible = true
		$"torch zone".monitoring = true
		$"torch zone/success".play()
		sound_played = true
		$CanvasModulate.visible = true
		

func _on_restart_pressed():
	hud._on_restart_pressed()

func _on_quit_pressed():
	hud._on_quit_pressed()

func _on_fade_area_body_entered(body):
	if body.name == "top down runner" && !faded:
		$AnimationPlayer.play("fade canvas")
		$AnimationPlayer.playback_speed = abs(globals.player.position.x)/100
		print(abs(globals.player.position.x)/50)
		faded = true

func _on_fade_back_body_entered(body):
	if body.name == "top down runner" && faded:
		$AnimationPlayer.play("unfade canvas")
		$AnimationPlayer.playback_speed = abs(globals.player.position.x)/50
		faded = false

func _on_zone_1_body_entered(body):
	if body.name == "word 1" && !word_1_correct:
		body.sleeping = true
		correct_count += 1
		word_1_correct = true
		$"word puzzle/word 4".visible = false

func _on_zone_2_body_entered(body):
	if body.name == "word 2" && !word_2_correct:
		body.sleeping = true
		correct_count += 1
		word_2_correct = true
		$"word puzzle/word 5".visible = false

func _on_zone_3_body_entered(body):
	if body.name == "word 3" && !word_3_correct:
		body.sleeping = true
		correct_count += 1
		word_3_correct = true
		$"word puzzle/word 6".visible = false

func _on_torch_zone_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("torch")
		$"torch zone".visible = false
		$"torch zone".set_deferred("monitoring", false)
		correct_count = 0
		globals.player.light_up()

func _on_fade_out_body_entered(body):
	if body.name == "top down runner":
		print("fading out")
		$"fade out/AnimationPlayer".play("fade_out")
		$CanvasModulate.visible = true
		
func _on_fade_out_body_exited(body):
	if body.name == "top down runner":
		print("fading in")
		$"fade out/AnimationPlayer".play("fade_in")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		faded = true
	if anim_name == "fade_in":
		faded = false

func _on_exit_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("escape")
		globals.is_lit = true
		
func return_to_dorm():
	globals.illuminata_completed = true
	global_ui.fade_in()
	globals.goto_scene("res://scenes/levels/dorm.tscn")

func fade_out():
	global_ui.fade_out()

func _on_death_body_entered(body):
	if body.name == "top down runner":
		restart("oh bats!", "maybe he is afraid of something?!")
