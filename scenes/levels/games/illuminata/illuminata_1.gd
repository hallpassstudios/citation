extends Node2D

func _ready():
	

	# fade in the level
	global_ui.fade_in()
	yield(get_tree().create_timer(2.0), "timeout")

	# play welcome
	dialogue_controller.play_dialogue('illuminata tutorial')


func _on_Area2D_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement 2')

func _on_Area2D2_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement 3')

func _on_Area2D3_body_entered(body):
		if body.name == "player":
			dialogue_controller.play_dialogue('illuminata movement 4')

func _on_Area2D4_body_entered(body):
	if body.name == "player":
		dialogue_controller.play_dialogue('illuminata movement')
