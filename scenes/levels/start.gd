extends Control

func _ready():
	print("we are in the main menu")

func _on_Button_pressed():
	print("we pressed the button")
	globals.goto_scene("res://scenes/levels/dorm.tscn")
	
