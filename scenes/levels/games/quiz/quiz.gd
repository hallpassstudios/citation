extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"

var question_1 : bool = false
var question_2 : bool = false
var question_3 : bool = false
var question_4 : bool = false
var question_5 : bool = false
var question_6 : bool = false
var question_7 : bool = false
var question_8 : bool = false
var question_9 : bool = false

var explanation_1 : bool = false
var explanation_2 : bool = false
var explanation_3 : bool = false
var explanation_4 : bool = false
var explanation_5 : bool = false
var explanation_6 : bool = false
var explanation_7 : bool = false
var explanation_8 : bool = false
var explanation_9 : bool = false


var timer
var timer_started

# Called when the node enters the scene tree for the first time.
func _ready():
	# clear color to black
	VisualServer.set_default_clear_color(Color(0,0,0,0.0))
	# spawn player
	var current_player = player.instance()
	globals.player = current_player
	add_child(current_player)
	current_player.position = spawn.position
	global_ui.fade_in()
	# dialogue_controller.play_dialogue("quiz")
	
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	
func _process(delta):
	if timer_started:
		$HUD/timer_label.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]

func _on_exit_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("completed quiz")
		analytics.objective_completed("completed quiz", {
			"elapsed_time": OS.get_ticks_msec()
		})
		globals.goto_scene("res://scenes/levels/dorm.tscn")
		globals.completed_quiz = true

func start_timer():
	timer_started = true
	print("starting timer...")
	timer.start(120)

func on_timer_timeout():
	print("time is up!")
	timer.stop()

func _on_sign_body_entered(body):
	if body.name == "top down runner" && !question_1:
		dialogue_controller.play_dialogue("question 1")
		question_1 = true
		$sort/sign/AnimatedSprite.visible = false
		$HUD/timer_label.visible = true

func _on_question_1_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_1:
		dialogue_controller.play_dialogue("question 1 explanation")
		$"sort/question 1 explanation/AnimatedSprite".visible = false
		explanation_1 = true

func _on_sign2_body_entered(body):
	if body.name == "top down runner" && !question_2:
		dialogue_controller.play_dialogue("question 2")
		question_2 = true
		$sort/sign2/AnimatedSprite.visible = false

func add_time():
	print("adding time to the timer")
	timer.start(timer.time_left + 5)

func _on_question_2_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_2:
		dialogue_controller.play_dialogue("question 2 explanation")
		$"sort/question 2 explanation/AnimatedSprite".visible = false
		explanation_2 = true

func _on_sign3_body_entered(body):
	if body.name == "top down runner" && !question_3:
		dialogue_controller.play_dialogue("question 3")
		question_3 = true
		$sort/sign3/AnimatedSprite.visible = false

func _on_question_3_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_3:
		dialogue_controller.play_dialogue("question 3 explanation")
		$"sort/question 3 explanation/AnimatedSprite".visible = false
		explanation_3 = true

func _on_sign4_body_entered(body):
	if body.name == "top down runner" && !question_4:
		dialogue_controller.play_dialogue("question 4")
		question_4 = true
		$sort/sign4/AnimatedSprite.visible = false

func _on_question_4_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_4:
		dialogue_controller.play_dialogue("question 4 explanation")
		$"sort/question 4 explanation/AnimatedSprite".visible = false
		explanation_3 = true

func _on_sign5_body_entered(body):
	if body.name == "top down runner" && !question_5:
		dialogue_controller.play_dialogue("question 5")
		question_5 = true
		$sort/sign5/AnimatedSprite.visible = false

func _on_question_5_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_5:
		dialogue_controller.play_dialogue("question 5 explanation")
		$"sort/question 5 explanation/AnimatedSprite".visible = false
		explanation_5 = true

func _on_sign6_body_entered(body):
	if body.name == "top down runner" && !question_6:
		dialogue_controller.play_dialogue("question 6")
		question_6 = true
		$sort/sign6/AnimatedSprite.visible = false

func _on_question_6_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_6:
		dialogue_controller.play_dialogue("question 6 explanation")
		$"sort/question 6 explanation/AnimatedSprite".visible = false
		explanation_6 = true

func _on_sign7_body_entered(body):
	if body.name == "top down runner" && !question_7:
		dialogue_controller.play_dialogue("question 7")
		question_7 = true
		$sort/sign7/AnimatedSprite.visible = false

func _on_question_7_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_7:
		dialogue_controller.play_dialogue("question 7 explanation")
		$"sort/question 7 explanation/AnimatedSprite".visible = false
		explanation_7 = true

func _on_sign8_body_entered(body):
	if body.name == "top down runner" && !question_8:
		dialogue_controller.play_dialogue("question 8")
		question_8 = true
		$sort/sign8/AnimatedSprite.visible = false

func _on_question_8_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_8:
		dialogue_controller.play_dialogue("question 5 explanation")
		$"sort/question 8 explanation/AnimatedSprite".visible = false
		explanation_8 = true

func _on_sign9_body_entered(body):
	if body.name == "top down runner" && !question_9:
		dialogue_controller.play_dialogue("question 9")
		question_9 = true
		$sort/sign9/AnimatedSprite.visible = false

func _on_question_9_explanation_body_entered(body):
	if body.name == "top down runner" && !explanation_9:
		dialogue_controller.play_dialogue("question 5 explanation")
		$"sort/question 9 explanation/AnimatedSprite".visible = false
		explanation_9 = true
