extends Node2D

func fade_in(song):
	song.play()
	song.handle_fade('in')
	start_at_pos(song,'fade_in')
	
func fade_out(song):
	song.handle_fade('out')
	
func play(song):
	song.play()
	start_at_pos(song, 'play')

func goto_pos(song):
	start_at_pos(song, 'goto_pos')
	
func get_pos(song):
	return song.song_file.get_playback_position()

func start_at_pos(song, handler_function):
	song.song_file.seek(_get_position(song, handler_function))

func _get_fade_threshold(song, handler_function):
	var threshold = 0
	
func _get_position(song, handler_function):
	var position = 0
	if typeof(song.get_param('on_start')[handler_function]) != TYPE_DICTIONARY: return position
	if song.get_param('on_start')[handler_function].has('at_sec'):
		position = float(song.get_param('on_start')[handler_function]['at_sec'])
	elif song.get_param('on_start')[handler_function].has('at_beat'):
		position = float(song.get_param('on_start')[handler_function]['at_beat']) * song.spb
	return position
