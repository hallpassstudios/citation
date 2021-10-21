extends Node2D

onready var player = preload("res://scenes/player/top_down_runner.tscn")
onready var spawn = $"sort/spawner"
onready var prompt = $"computer input/TextureRect/Panel/prompt"
onready var password = $"computer input/TextureRect/Panel/password"
var password_string : String
var password_shown : bool
var cheated : bool
var has_a_book: bool

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
	global_ui.fade_in()

func restart(title, subtitle):
	$HUD/restart.visible = true
	$HUD/restart/VBoxContainer/title.text = title
	$HUD/restart/VBoxContainer/subtitle.text = subtitle
	get_tree().paused = true

func _on_restart_pressed():
	print("pressed restart")
	$HUD/restart.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	globals.goto_scene("res://scenes/levels/dorm.tscn")
	
# really should not be so lazy...
	
func _on_Submit_pressed():
	get_tree().paused = false
	if password.text =="PASSWORD":
		cheated = true
		prompt.text = "password correct"
		$"computer input/TextureRect/Panel".visible = false
		$"computer input/TextureRect/question".visible = true
		password_shown = true
		
	else:
		prompt.text = "incorrect password!"
		password_string = ""
		password.text = ""
		yield(get_tree().create_timer(1.0), "timeout")
		prompt.text = "enter password"

func _on_A_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "A"
		password.text = password_string

func _on_B_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "B"
		password.text = password_string

func _on_C_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "C"
		password.text = password_string
func _on_D_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "D"
		password.text = password_string

func _on_E_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "E"
		password.text = password_string

func _on_F_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "F"
		password.text = password_string

func _on_G_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "G"
		password.text = password_string

func _on_H_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "H"
		password.text = password_string

func _on_I_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "I"
		password.text = password_string

func _on_J_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "J"
		password.text = password_string

func _on_K_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "K"
		password.text = password_string

func _on_L_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "L"
		password.text = password_string

func _on_M_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "M"
		password.text = password_string

func _on_N_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "N"
		password.text = password_string

func _on_O_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "O"
		password.text = password_string

func _on_Q_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "Q"
		password.text = password_string

func _on_P_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "P"
		password.text = password_string

func _on_R_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "R"
		password.text = password_string

func _on_S_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "S"
		password.text = password_string

func _on_T_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "T"
		password.text = password_string

func _on_U_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "U"
		password.text = password_string

func _on_V_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "V"
		password.text = password_string

func _on_W_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "W"
		password.text = password_string

func _on_X_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "X"
		password.text = password_string

func _on_Y_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "Y"
		password.text = password_string

func _on_Z_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string = password_string + "Z"
		password.text = password_string

func _on_BACKSPACE_gui_input(event):
	if event.is_action_pressed("click") || (event is InputEventScreenTouch 	and event.pressed == false):
		password_string.erase(password_string.length() - 1, 1)
		password.text = password_string

func _on_TextureRect_gui_input(event):
	if password_shown:
		if event.is_action_pressed("click"):
			$"computer input/TextureRect".visible = false

func _on_computer_body_entered(body):
	if body.name == "top down runner" && !cheated:
		$"computer input/TextureRect".visible = true
		get_tree().paused = true

func _on_Exit_pressed():
	$"computer input/TextureRect".visible = false
	get_tree().paused = false

func _on_cabinet_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("password")

func _on_books_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("books")

func took_books():
	has_a_book = true

func _on_seat_body_entered(body):
	if body.name == "top down runner":
		if cheated || has_a_book:
			dialogue_controller.play_dialogue("cheated on test")
			global_ui.fade_out()
			yield(get_tree().create_timer(1.0), "timeout")
			globals.goto_scene("res://scenes/levels/games/minigame/chunks/office.tscn")
		else:
			print("didn't cheat")
			global_ui.fade_out()
			globals.goto_scene("res://scenes/levels/games/minigame/chunks/did_not_cheat.tscn")

func open_door():
	print('door is opening')
	$sort/door.visible = false
	$sort/door.monitoring = false
	$sort/door/StaticBody2D/CollisionShape2D.disabled = true
	
func _on_door_body_entered(body):
	if body.name == "top down runner":
		dialogue_controller.play_dialogue("door")
