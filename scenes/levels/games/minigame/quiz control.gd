extends Control

var timer
var wait_time
onready var progress = $"question/question container/progress"
var weight
export var difficulty = 1
var available_questions : Array
var next_question : int
onready var answer = $answer
onready var question_text = $"question/question container/question"
onready var button_1 = $"answer/answer container/1"
onready var button_2 = $"answer/answer container/2"
var correct_answer : int
var selected_answer : int
var number_correct = 0

export (NodePath) var player

enum STATE {
	SHOWING = 0,
	WAITING = 1
}

var state = STATE.WAITING

var data = {
  "module": {
	"number": 0,
	"name": "Plagiarism",
	"questions": 30,
	"revision": "2017-08-13"
  },
  "questions": [
	{
	  "number": 1,
	  "question": "A friend asks you to help them write a short section of their paper...",
	  "type": "binary",
	  "answers": [
		"That's cheating!",
		"That's okay!",
	  ],
	  "correct_answer": 1
	},
	{
	  "number": 2,
	  "question": "Paraphrasing is okay in the following circumstances:",
	  "type": "binary",
	  "answers": [
		"never",
		"when the professor says so",
	  ],
	  "correct_answer": 1
	},
	{
	  "number": 3,
	  "question": "Each school at NYU may establish additional guidelines on academic integrity",
	  "type": "binary",
	  "answers": [
		"incorrect",
		"that's correct",
	  ],
	  "correct_answer": 2
	},
	{
	  "number": 4,
	  "question": "Students are expected to adhere to the norms and standards of academic integrity espoused by the NYU community.",
	  "type": "binary",
	  "answers": [
		"true",
		"false",
	  ],
	  "correct_answer": 1
	},
  ]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	
	# connect our button signals
	button_1.connect("gui_input", self, "button_1_pressed")
	button_2.connect("gui_input", self, "button_2_pressed")
	# create an array with all questions
	for i in data.questions.size():
		available_questions.append(i)
	
	# choose a question
	choose_question()
	
func _process(delta):
	# handle our timer when we're showing a question, should probably lerp this
	if state == STATE.SHOWING:
		progress.value = timer.time_left * weight

func choose_question():
	if available_questions.size() == 0:
		# recycle our questions
		for i in data.questions.size():
			available_questions.append(i)

	# show the UI
	$question.visible = true
	answer.visible = false

	# choose a random question from our array and remove it
	# init random number gen
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_index = random.randi_range(0,available_questions.size() - 1)
	next_question = available_questions[random_index]
	available_questions.remove(random_index)
	# display the question
	question_text.text = data.questions[next_question].question
	
	# change our state
	state = STATE.SHOWING
	
	# set our timer to be fair, based on the character count
	var char_count = data.questions[next_question].question.count(" ")
	var wait_time = char_count / difficulty
	timer.start(wait_time)
	weight = 100/wait_time
	
	# store the correct answer
	correct_answer = data.questions[next_question].correct_answer

func on_timer_timeout():
	# state is now waiting
	state = STATE.WAITING
	timer.stop()
	print("time is up, showing answers")
	
	# update our move animation based on difficulty level
	# globals.player.move_speed = globals.player.move_speed * difficulty/4
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawn_time = rng.randf_range(-1.0, 1.0)

	# show our answers (in this case we do want to match on type but for now just binary)
	answer.visible = true
	$question.visible = false
	
	# need to randomize the questions
	for i in data.questions[next_question].answers.size():
		if i == 0:
			button_1.text = data.questions[next_question].answers[i]
		if i <= 5: 
			button_2.text = data.questions[next_question].answers[i]

	# spawn an obstacle and send it a difficulty level
	yield(get_tree().create_timer(spawn_time), "timeout")
	get_tree().get_root().get_node("main").spawn_obstacle(difficulty)

func button_1_pressed(event):
	if Input.is_action_pressed("click") || event.is_pressed():
		print("correct answer is: ", correct_answer)
		if correct_answer == 1:
			$"answer label".visible = true
			$"answer label".text = "CORRECT"
			globals.player.jump()
			number_correct += 1
			yield(get_tree().create_timer(.5), "timeout")
			$"answer label".visible = false
		else:
			$"answer label".visible = true
			$"answer label".text = "INCORRECT OH NO!"
			yield(get_tree().create_timer(.5), "timeout")
			$"answer label".visible = false
		choose_question()

func button_2_pressed(event):
	if Input.is_action_pressed("click") || event.is_pressed():
		print("correct answer is: ", correct_answer)
		if correct_answer == 2:
			$"answer label".visible = true
			$"answer label".text = "CORRECT"
			globals.player.jump()
			number_correct += 1
			yield(get_tree().create_timer(.5), "timeout")
			$"answer label".visible = false
		else:
			$"answer label".visible = true
			$"answer label".text = "INCORRECT OH NO!"
			yield(get_tree().create_timer(.5), "timeout")
			$"answer label".visible = false
		choose_question()

