extends Control

var current_animation = 0
var timer

var page_1 : Label
var page_2 : Label
var page_3 : Label
var page_4 : Label


func _ready():
	next_page()

func _on_AnimatedSprite_animation_finished():
	current_animation += 1
	# wait a fixed amount of time and then go to the next page
	
	# play a loop animation
	$AnimatedSprite.play("cycle 1")
	
func next_page():
	
	match current_animation:
		1:
			print("here's page 1")
			$AnimatedSprite.play(str(current_animation))
	

func _on_Button_pressed():
	next_page()

