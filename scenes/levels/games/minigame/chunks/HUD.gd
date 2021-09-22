extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func restart(title, subtitle):
	$restart.visible = true
	$restart/VBoxContainer/title.text = title
	$restart/VBoxContainer/subtitle.text = subtitle
	
	# stop our character from moving
	globals.player.can_move = false

func _on_restart_pressed():
	globals.player.can_move = true
	print("pressed restart")
	globals.goto_scene("res://scenes/levels/games/minigame/chunks/final.tscn")

func _on_quit_pressed():
	globals.goto_scene("res://scenes/levels/dorm.tscn")
