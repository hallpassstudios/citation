extends Control

onready var confirm = $"Confirm Quit"
onready var quit = $"Quit Menu"

func _on_Start_pressed():
	get_tree().reload_current_scene()

func _on_Quit_pressed():
	confirm.visible = true
	quit.visible = false
	
func _on_Confirm_pressed():
	get_tree().quit()

func _on_No_pressed():
	get_tree().reload_current_scene()
