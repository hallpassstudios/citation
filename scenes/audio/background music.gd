extends Node2D

var songCopy = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var base = $base
onready var excellent = $excellent
onready var bad = $bad


func loop(song):
	# get audio file data : BPM and total beats in song
	# will use process time rather than delta time
	if !song.is_playing():
		song.play()
		
	if song.is_playing() and song.reached_end():
		
		if songCopy == null:
			#instantiate a new song scene
			var songScene = PackedScene.new()
			songScene.pack($song)
			songCopy = songScene.instance()
			add_child(songCopy)
			
			#Give songCopy props (that it is a copy, and current song's prop)
			songCopy.add_stream($song.song_filename)
			songCopy.isCopy = true
			
		#Handle playback positions
		var song_playback = $song.song_file.get_playback_position()
		songCopy.song_file.play()
		songCopy.song_file.seek(song_playback)
		print($song.song_file.get_playback_position(), " ", song_playback)
		$song.song_file.seek(0)
		
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func play():
	loop($song)

func _process(delta):
	loop($song)
