extends Control

func play_dialogue(dialogue_name):
	pause(true)	
	globals.player.can_move = false
	var dialogue = Dialogic.start(dialogue_name, true)
	add_child(dialogue)
	dialogue.connect("dialogic_signal", self, "pause")
	dialogue.connect('timeline_end', self, 'after_dialog')

# helper functions
func pause(value):
	if value:
		get_tree().paused = true
		print("pausing before dialogue")
		
func after_dialog(timeline_name):
	print("unpausing after dialogue")
	get_tree().paused = false
	yield(get_tree().create_timer(.5), "timeout")
	globals.player.can_move = true
	
