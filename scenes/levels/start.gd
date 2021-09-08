extends Control

func _ready():
	pass

func _on_Button_pressed():
	print("we pressed the button")
	globals.goto_scene("res://scenes/levels/intro.tscn")
	
