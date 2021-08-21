extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer
onready var label = $"Time"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.set_wait_time(60)
	timer.start() #to start


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(int(timer.time_left) % 60)

func _on_timer_timeout():
   game_over()

func game_over():
	print("game over")
