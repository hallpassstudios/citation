extends Control

var current_animation = 0
var current_animation_finished = false
var timer

var page_1 : Label
var page_2 : Label
var page_3 : Label
var page_4 : Label

var next_pressed
var press_received = false


func _ready():
	global_ui.fade_in()
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start(7)
	# wait a few secs then play our animation?
	# yield(get_tree().create_timer(1.0), "timeout")
	next_page()

func _on_AnimatedSprite_animation_finished():
	current_animation_finished = true
	# wait a fixed amount of time and then go to the next page
	
	# play a loop animation depending on current animation:
#	if current_animation == 0:
#		$AnimatedSprite.play("cycle 1")
#	if current_animation == 1:
#		$AnimatedSprite.play("cycle 2")
#	if current_animation == 2:
#		$AnimatedSprite.play("cycle 3")
#	if current_animation == 3:
#		$AnimatedSprite.play("cycle 4")

	if current_animation < 4:
		$AnimatedSprite.play("cycle %d" % (current_animation + 1))
	
func next_page():
	current_animation_finished = false
	print("showing next animation")
	print(current_animation)
	match current_animation:
		0:
			print("playing animation 0")
			$AnimatedSprite.play(str(current_animation))
			$"title 1".visible = true
		1:
			next_pressed = false
			print("here's page 1")
			print(current_animation)
			$AnimatedSprite.play(str(current_animation))
			$"title 1".visible = false
			yield(get_tree().create_timer(1.0), "timeout")
			if current_animation == 1:
				$"title 2".visible = true
		2: 
			next_pressed = false
			print("here's page 2")
			$AnimatedSprite.play(str(current_animation))
			$"title 2".visible = false
			$"title 3".visible = true
			yield(get_tree().create_timer(2.0), "timeout")
			if current_animation == 2:
				$"title 4".visible = true
				$"title 5".visible = true

		3: 
			next_pressed = false
			print("here's page 3")
			$"title 3".visible = false
			$"title 4".visible = false
			$"title 5".visible = false
			$AnimatedSprite.play(str(current_animation))
			yield(get_tree().create_timer(1.0), "timeout")
			if current_animation == 3:
				$"title 6".visible = true

		4: 
			next_pressed = false
			print("here's page 4")
			$AnimatedSprite.play(str(current_animation))
			$"title 6".visible = false
			$"title 7".visible = true
			$Button.visible = false
			yield(get_tree().create_timer(3.0), "timeout")
			globals.goto_scene("res://scenes/levels/dorm.tscn")

func on_timer_timeout():
	if current_animation < 4:
		print("timer timedout")
		# go to next animation
		current_animation += 1
		next_page()

func _on_Button_pressed():
	# stop our sprite
	$AnimatedSprite.stop()
	
	# reset countdown
	timer.start(7)
	
	# what's our current animation?
	print("current animation is: ", current_animation)
	print("next animation is: ", current_animation + 1)
#	match current_animation:
#		0:
#			print("never showing title 1 again")
#		1:
#			print("never showing title 2 again")
#		2:
#			print("never showing title 3 again")
#		3:
#			print("never showing title 4 again")
#		4:
#			print("never showing title 5 again")
#		5:
#			print("never showing title 6 again")
#		6:
#			print("never showing title 7 again")
			
	current_animation += 1
	next_page()
