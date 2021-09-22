extends Control

var current_animation = 0
var current_animation_finished = false
var timer

var page_1 : Label
var page_2 : Label
var page_3 : Label
var page_4 : Label

var next_pressed

func _ready():
	global_ui.fade_in()
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start(7)
	# wait a few secs then play our animation?
	# yield(get_tree().create_timer(1.0), "timeout")
	next_page()

func _process(delta):
	if current_animation_finished:
		pass

func _on_AnimatedSprite_animation_finished():
	current_animation_finished = true
	# wait a fixed amount of time and then go to the next page
	
	# play a loop animation depending on current animation:
	if current_animation == 0:
		$AnimatedSprite.play("cycle 1")
	if current_animation == 1:
		$AnimatedSprite.play("cycle 2")
	if current_animation == 2:
		$AnimatedSprite.play("cycle 3")
	if current_animation == 3:
		$AnimatedSprite.play("cycle 4")
	
func next_page():
	current_animation_finished = false
	print("showing next animation")
	print(current_animation)
	match current_animation:
		0:
			next_pressed = false
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
			$"title 2".visible = true
			if next_pressed:
				$"title 2".visible = true
		2: 
			next_pressed = false
			print("here's page 2")
			$AnimatedSprite.play(str(current_animation))
			$"title 2".visible = false
			$"title 3".visible = true
			yield(get_tree().create_timer(2.0), "timeout")
			$"title 4".visible = true
			$"title 5".visible = true
			if next_pressed:
				$"title 4".visible = true
				yield(get_tree().create_timer(2.0), "timeout")
				$"title 5".visible = true

		3: 
			next_pressed = false
			print("here's page 3")
			$"title 3".visible = false
			$"title 4".visible = false
			$"title 5".visible = false
			$AnimatedSprite.play(str(current_animation))
			yield(get_tree().create_timer(1.0), "timeout")
			$"title 6".visible = true
			if next_pressed:
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
	next_pressed = true
	$AnimatedSprite.stop()
	$"title 1".visible = false
	$"title 2".visible = false
	$"title 3".visible = false
	$"title 4".visible = false
	$"title 5".visible = false
	$"title 6".visible = false
	$"title 7".visible = false
	current_animation += 1
	next_page()

