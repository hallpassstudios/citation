extends CanvasLayer

func _ready():
	$"Score Value".text = str(globals.score)
	
func _on_Quit_pressed():
	get_tree().quit()

func _on_Restart_pressed():
	globals.goto_scene("res://scenes/levels/start.tscn")

func _on_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_Settings_Button_toggled(button_pressed):
	print(button_pressed)

func _on_close_pressed():
	$Control.visible = false

func _on_Settings_Button_pressed():
	$Control.visible = true

func increase_score(value):
	print("increasing score")
	globals.score += int(value[0])
	$"Score Value".text = str(globals.score)
	
func decrease_score(value):
	print("decreasing score")
	globals.score -= int(value[0])
	$"Score Value".text = str(globals.score)
