extends Control

func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	# just get our dialogue working 
	var intro_dialogue = Dialogic.start('intro')
	add_child(intro_dialogue )
	intro_dialogue.connect("dialogic_signal", self, "pause")

func pause(value):
	if value == "pause":
		get_tree().paused = true
		print("pausing")
	if value == "unpause":
		get_tree().paused = false
		print("unpausing")
