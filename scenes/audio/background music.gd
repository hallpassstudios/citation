extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bg_1 = $bg_1
onready var bg_2 = $bg_2

func loop(song):
	# get audio file data : BPM and total beats in song
	# will use process time rather than delta time
	if !song.is_playing() or song.reached_end():
		print("playing")
		song.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func play():
	loop($song)

func _process(delta):
	loop($song)
