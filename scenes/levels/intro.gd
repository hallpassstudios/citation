extends Control

var current_animation = 0

func _ready():
	next_page()

func _on_AnimatedSprite_animation_finished():
	current_animation += 1
	# wait a fixed amount of time and then go to the next page
	next_page()
	
	
func next_page():
	$AnimatedSprite.play(str(current_animation))

func _on_Button_pressed():
	next_page()
