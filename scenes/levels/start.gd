extends Control

var timer
var analytics_data = {
	"thing 1": 1,
	"thing 2": "wow!"
}

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start(10)
	
func _on_Start_pressed():
	globals.goto_scene("res://scenes/levels/name.tscn")
	analytics.objective_completed("started the game", analytics_data)

func _on_Backstory_pressed():
	globals.goto_scene("res://scenes/levels/backstory.tscn")

func on_timer_timeout():
	globals.goto_scene("res://scenes/levels/backstory.tscn")

func _on_Control_gui_input(event):
	timer.stop()
	timer.start(10)
	
