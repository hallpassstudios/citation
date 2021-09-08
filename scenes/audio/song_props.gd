extends Node

onready var song_file = $song_file
export(String) var song_filename = ""
export(int) var bpm = 0 
export(int) var total_beats = 0
var spb = 0.0
func _ready():
	if song_filename != "":
		var audioStream: AudioStream = load(song_filename)
		song_file.set_stream(audioStream)
	spb = 60.0 / bpm

func play():
	song_file.play()

func is_playing():
	return song_file.is_playing()
	
func reached_end():
	#print(spb," ", bpm," ", total_beats)
	#print("SONG FIL PLAYBACK: ", song_file.get_playback_position())
	#print("total seconds for song ", float(spb*total_beats))
	return song_file.get_playback_position() > float(spb * total_beats)
