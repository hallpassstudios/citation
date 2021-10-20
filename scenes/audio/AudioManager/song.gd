extends Node

onready var song_file = $song_file
var song_filename = ''
var trackname = ''
var spb = 1.0
var bpm = 1
var total_seconds = 0.0
var total_beats = 0
var song_length = 0
var prev_frame_beat = 0
var current_beat = 1
var original_volume = 0.0
var beats_to_emit_signal = {
	'#': 'ref_to_node_relative_to_current_scene'
}
var emitted_song_ended = false

var is_fading = false
var fade_direction = 0

signal music_cue(beat)
signal file_ended(song)
signal song_ended(song)
signal remove_me(song)

func handle_params(params): $song_params.params = params
func set_params(key, value): $song_params.params[key] = value
func get_params(): return $song_params.params
func has_param(key): return (get_param(key) != null)
func get_song_handler(): return get_param('song_handler')

func get_param(key):
	if $song_params.params.has(key):
		return $song_params.params[key]
	else:
		return null

func set_ready():
	#====Set up beats to emit signal
	beats_to_emit_signal = get_param('beats_to_emit_signal')
	if not beats_to_emit_signal: beats_to_emit_signal = {}
	
	#=====Handle Audio Stream + Audio Props
	add_stream(song_filename)
	song_length = song_file.stream.get_length()
	spb = 60.0 / bpm
	total_seconds = spb * total_beats
	
	#=====Set up Signal Connections
	#SongHandler connections
	var song_handler = get_song_handler()
	connect('song_ended', song_handler, '_on_song_reached_end')
	connect('file_ended', song_handler, '_on_song_file_end')
	connect('remove_me', song_handler, '_on_remove_request')
	
	#User-Set Connections
	for beat in beats_to_emit_signal:
		var object = get_node(beats_to_emit_signal[beat])
		if object:
			connect('music_cue', object, '_on_music_cue')
			
func _process(_delta):
	current_beat = stepify( stepify(song_file.get_playback_position(), 0.001) / spb , 1) + 1
	if current_beat != prev_frame_beat:
		if beats_to_emit_signal.has(str(current_beat)):
			emit_signal('music_cue', current_beat)
	prev_frame_beat = current_beat
	
	if reached_file_end():
		emit_signal('file_ended', self)
		
	if reached_song_end() and not emitted_song_ended:
		emit_signal('song_ended', self)
		emitted_song_ended = true
		
	if is_fading:
		var curr_volume = get_volume()
		var fade_speed = 5
		if fade_direction == -1:
			fade_speed = 0.3
		set_volume(curr_volume + (fade_speed*fade_direction))
		if (curr_volume >= original_volume and fade_direction == 1) or (curr_volume <= -80.0 and fade_direction == -1):
			if fade_direction == 1: curr_volume = original_volume
			elif fade_direction == -1: curr_volume = -80.0
			set_volume(curr_volume)
			set_volume(curr_volume)
			is_fading = false
			if fade_direction == -1: emit_signal('remove_me', self)
		
func add_stream(song_filename):
	if song_filename != "":
		var audioStream: AudioStream = load(song_filename)
		song_file.set_stream(audioStream)
		
func play():
	song_file.play()

func stop():
	song_file.stop()

func get_volume():
	return song_file.volume_db
	
func set_volume(num):
	song_file.volume_db = float(num)
	
func handle_fade(direction_string):
	set_params("on_end","stop")
	if not is_fading:
		if direction_string == 'in':
			fade_direction = 1
			original_volume = get_volume()
			set_volume(-80.0)

		elif direction_string == 'out':
			fade_direction = -1
			original_volume = get_volume()
			set_volume(original_volume)
		else:
			fade_direction = 1
		is_fading = true
			
func is_playing():
	return song_file.is_playing()
	
func reached_song_end():
	return stepify(song_file.get_playback_position(), 0.001) >= total_seconds

func reached_file_end():
	return stepify(song_file.get_playback_position(), 0.1) + 0.1 >= song_length
