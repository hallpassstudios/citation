extends Node

signal load_track_request(next_song, new_song_params)

var songs = []

onready var handler_functions = $handler_functions
onready var handler_types = {
	'fade_in': funcref(handler_functions, 'fade_in'),
	'fade_out': funcref(handler_functions, 'fade_out'),
	'play': funcref(handler_functions, 'play'),
	'goto_position': funcref(handler_functions, 'goto_position')
}

onready var on_end_callbacks = $on_end_callbacks
onready var on_end_types = {
	'loop': funcref(on_end_callbacks, 'loop'),
	'stop': funcref(on_end_callbacks, 'stop'),
	'next': funcref(on_end_callbacks, 'next')
}

func _ready():
	connect('load_track_request', get_parent(), '_on_load_track_request')

func load_track(track, song_params):
	var base_path = get_script().resource_path
	var trimmed_path = base_path.substr(0, len(base_path)-15)
	var songScene = load(trimmed_path + 'song.tscn')
	var song = songScene.instance()
	add_child(song)
	songs.append(song)
	song.trackname = track.name
	song.song_filename = track.filename
	song.bpm = track.bpm
	song.total_beats = track.total_beats
	song_params['song_handler'] = self
	if not song_params.has('on_end'):
		song_params['on_end'] = 'loop'
	song.handle_params(song_params)
	song.set_ready()
	
func _process(_delta):
	for song in songs:
		handle(song)

func get_current_songs():
	return songs

func get_pos(song=null):
	if !song:
		for song in songs:
			return song.song_file.get_playback_position()
	else:
		return song.song_file.get_playback_position()
	
func clear():
	for song in songs:
		remove_song(song)

func handle(song):
	if !song.is_playing(): 
		if song.has_param('on_start'):
			_on_song_start(song)
		else:
			song.play()

func remove_song(song):
	song.stop()
	songs.erase(song)
	song.queue_free()

func _on_song_start(song):
	var on_start_func = null
	if song.has_param('on_start'):
		for param in song.get_param('on_start'):
			on_start_func = handler_types[param]
			on_start_func.call_func(song)
	else:
		on_start_func = 'play'
		on_start_func.call_func(song)
	#implement, to take parameters based on a specific playback position using seconds, OR by beat
	
func _on_song_reached_end(song):
	var on_end_func = null
	if song.has_param('on_end'):
		on_end_func = on_end_types[song.get_param('on_end')]
	elif song.has_param('other_callback'):
		on_end_func = on_end_types[song.get_param('other_callback')]
	else:
		on_end_func = on_end_types['loop']
	on_end_func.call_func(song)
	
func _on_song_file_end(song):
	remove_song(song)

func _on_load_track_request(song, song_params):
	emit_signal('load_track_request', song, song_params)
	
func _on_remove_request(song):
	remove_song(song)
