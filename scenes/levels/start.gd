extends Control

func _ready():
	print("we are in the main menu")
	
	# just get our dialogue working
	var new_dialog = Dialogic.start('intro')
	add_child(new_dialog)

func _on_Button_pressed():
	print("we pressed the button")
	globals.goto_scene("res://scenes/levels/dorm.tscn")
	
