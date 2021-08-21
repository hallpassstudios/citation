extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score
onready var label = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = globals.player_score
	label.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score = globals.player_score
	label.text = str(score)
