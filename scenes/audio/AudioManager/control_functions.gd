extends Node2D

signal load_track_request(song, params)
var has_handler = false
var handler = null

func _ready():
	connect("load_track_request", get_parent(), '_on_load_track_request')
	
func play(action):
	var song = null
	for root in action:
		song = root
	var params = action[song]
	get_parent().play(song, params)
	
func transition_to(action):
	#TODO: check if there are any songs playing, else start from beginning
	#TODO: get songs that are playing, fade out
	#TODO: fade in this song
	var songs = get_parent().get_current_songs()
	if len(songs) == 0:
		play(action)
	else:
		var start_pos = 0
		for song in songs:
			start_pos = handler.get_pos()
			handler.handler_types['fade_out'].call_func(song)
		var song = null
		for root in action:
			song = root
		var params = action[song]
		params['on_start'] = {'fade_in' : {'at_sec':str(start_pos)}}
		emit_signal('load_track_request', song, params)
			
func cut_to(action): #change to cut to
	pass
func play_sfx(action):
	pass
	
func fade_out(action):
	var songs = get_parent().get_current_songs()
	if len(songs) == 0: return
	var songs_to_fade = []
	if len(action) == 0:
		songs_to_fade = songs
	else:
		for song in action:
			songs_to_fade.append(song)
	for song in songs:
		if songs_to_fade.has(song):
			var start_pos = handler.get_pos(song)
			handler.handler_types['fade_out'].call_func(song)

func validate():
	if not has_handler:
		handler = get_parent().get_node("song_handler")
