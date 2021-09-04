extends Node

onready var song_file = $song_file
export(String) var song_filename = ""
export(int) var bpm = 0 
export(int) var total_beats = 0
var isCopy = false
var spb = 0.0
var total_seconds = 0.0
var song_length = 0

func _ready():
	add_stream(song_filename)
	spb = 60.0 / bpm
	total_seconds = spb * total_beats

func _process(delta):
	if isCopy:
		if stepify(song_file.get_playback_position(), 0.01) + 0.10 >= song_length:
			print("copy reached end")
			get_parent().songCopy = null
			get_parent().remove_child(self)

func add_stream(song_filename):
	if song_filename != "":
		var audioStream: AudioStream = load(song_filename)
		song_file.set_stream(audioStream)
	song_length = stepify(song_file.stream.get_length(), 0.01) 
		
func play():
	song_file.play()

func is_playing():
	return song_file.is_playing()
	
func reached_end():
	return stepify(song_file.get_playback_position(), 0.01) >= total_seconds
	
	
