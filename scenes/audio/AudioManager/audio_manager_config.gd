extends Node

signal configured

var tracks = {}
var audio_actions = {}
var state_directory = {}
var trees = {}

func _create_action(name, track_name, params = {}): return Audio_Action.new(name, track_name, params)
func _create_track_obj(name, bpm, total_beats, filename=null): 
	var fn = ''
	if filename == null:
		fn = 'res://audio/' + name + '.mp3'
	else:
		fn = filename
	return Track.new(name, bpm, total_beats, fn)

func _ready():
	connect('configured', get_parent(), '_on_configured')
	_handle_config()
	
func _handle_config():
	var config = ConfigFile.new()
	var base_path = get_script().resource_path
	var trimmed_path = base_path.substr(0, len(base_path)-23)
	var err = config.load(trimmed_path + 'audio.cfg')
	if err == OK:
		print('Audio Manager configuration file loaded and parsed successfully!')
		tracks = get_tracks(config)
		audio_actions = get_actions(config)
		state_directory = get_state_directory(config)
		trees = get_trees(config)
		emit_signal('configured')
	else:
		print('Audio Manager configuration failed. Does your config file have syntax errors?')

func get_trees(config):
	var section = 'Trees'
	var tree_keys = config.get_section_keys(section)
	var _trees = {}
	for key in tree_keys:
		var value = config.get_value(section, key)
		_trees[key] = value
	return _trees

func get_tracks(config):
	var section = 'Tracks'
	var track_keys = config.get_section_keys(section)
	var _tracks = {}
	for key in track_keys:
		var value = config.get_value(section, key)
		var new_track_obj = null
		if len(value) == 3:
			new_track_obj = _create_track_obj(key, value[0], value[1], value[2])
		elif len(value) == 2:
			new_track_obj = _create_track_obj(key, value[0], value[1])
		if new_track_obj == null:
			print('Track object not formatted correctly')
		_tracks[key] = new_track_obj
	return _tracks
	
func get_actions(config):
	var section = 'Actions'
	var action_keys = config.get_section_keys(section)
	var _actions = {}
	for key in action_keys:
		var value = config.get_value(section, key)
		_actions[key] = value
	return _actions

func get_state_directory(config):
	var section = 'State Variables'
	var state_dir_keys = config.get_section_keys(section)
	var _state_directory = {}
	for key in state_dir_keys:
		var value = config.get_value(section, key)
		var node = get_node(value[0])
		var new_funcref = funcref(node,value[1])
		_state_directory[key] = new_funcref
	return _state_directory
	
class Audio_Action:
	var name: String
	var track_name: String
	var params : Dictionary
	
	func _init(name, track_name, params):
		self.name = name
		self.track_name = track_name
		self.params = params
		
class Track:
	var name: String
	var filename: String
	var bpm: int
	var total_beats: int

	func _init(name, bpm, total_beats, filename):
		self.name = name
		self.bpm = bpm
		self.total_beats = total_beats
		self.filename = filename
