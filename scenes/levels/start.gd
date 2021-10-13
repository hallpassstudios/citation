extends Control

var timer
var analytics_data = {
	"thing 1": 1,
	"thing 2": "wow!"
}

func _ready():
	VisualServer.set_default_clear_color(Color(0.07,0.08,0.11,0.0))
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start(10)
	
func _on_Start_pressed():
	globals.goto_scene("res://scenes/levels/character select.tscn")
	analytics.set_objective("started the game")

func _on_Backstory_pressed():
	globals.goto_scene("res://scenes/levels/backstory.tscn")
	analytics.set_objective("viewed backstory")

func on_timer_timeout():
	globals.goto_scene("res://scenes/levels/backstory.tscn")
	analytics.set_objective("shown backstory")

func _on_Control_gui_input(event):
	timer.stop()
	timer.start(10)
	
