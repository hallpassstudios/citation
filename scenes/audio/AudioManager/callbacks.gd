extends Node2D

signal load_track_request(next_song, new_song_params)

func _ready():
	connect('load_track_request', get_parent(), '_on_load_track_request')
	
func stop(song):
	pass
		
func loop(song):
	emit_signal('load_track_request', song.trackname, song.get_params())
	
func next(song):
	var next_song = (null if not song.has_param('next_song') else song.get_param('next_song'))
	var next_song_params = ({'on_end' : 'loop'} if not song.has_param('new_song_params') else song.get_param('new_song_params'))
	if next_song == null: return
	emit_signal('load_track_request', next_song, next_song_params)
