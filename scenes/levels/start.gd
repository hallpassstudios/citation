extends Control

var timer

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start(10)
	
func _on_Start_pressed():
	globals.goto_scene("res://scenes/levels/intro.tscn")

func _on_Backstory_pressed():
	globals.goto_scene("res://scenes/levels/backstory.tscn")

func on_timer_timeout():
	globals.goto_scene("res://scenes/levels/backstory.tscn")

func _on_Control_gui_input(event):
	print("timer stopped")
	timer.stop()
	timer.start(10)
	
