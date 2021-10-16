extends Node2D

signal state_changed(action)
signal handle_error(err_message)

#=====State
onready var state_directory setget set_state_directory
func set_state_directory(sd): state_directory = sd

var state = {}
var prev_state = {}
var will_update = false

#=====Actions
onready var audio_actions setget set_audio_actions
func set_audio_actions(aa): audio_actions = aa

#=====Tree
onready var trees setget set_trees
func set_trees(t): trees = t

#======Example 
#Below Example is akin to the following tree
#
#          _Mode_
#        /     |                            \
#       base   |fire -> fire_audio|          |ice -> ice_audio|
#     
#	where base:
#
#     low_health?
#    /							\
#	|true -> low_health_audio|   |false -> base_regular_audio|
#

#var example = {
#	'mode' : {
#		'base_mode':{
#			'low_health':
#				{'true':'low_health_audio',
#				'false':'base'}}, 
#		'fire_mode':'fire',
#		'ice_mode':'ice'}
#}


func _ready():
	connect('state_changed', get_parent(), '_on_state_changed')
	connect('handle_error', get_parent(), '_on_error')
	state = get_state()
	
func get_state():
	var _state = {}
	for variable in state_directory:
		_state[variable] = str(state_directory[variable].call_func())
	print(_state)
	return _state

func _compare_dict(dict1, dict2):
	for key in dict1:
		if dict2.has(key):
			if dict1[key] != dict2[key]:
				return false
		else:
			return false
	return true
	
func traverse(tree, state):
	var node_param = null
	var path = null
	for root in tree:
		node_param = root
	path = tree[node_param]
	while typeof(path) != TYPE_STRING:
		var direction = ''
		if state.has(node_param):
			direction = str(state[node_param]).to_lower()
		else:
			emit_signal("handle_error", node_param + "not in the current tree path!")
			return
		if path.has(direction):
			path = path[direction]
		else:
			emit_signal('handle_error', direction + 'not in the current tree path!')
			return
		if typeof(path) == TYPE_STRING:
			break
		for root in path: #subtree
			node_param = root
		path = path[node_param]
	return path
	
func _process(delta):
	if not _compare_dict(state,prev_state):
		will_update = true
	if will_update:
		emit_signal('state_changed', audio_actions[traverse(trees['root'], state)])
		will_update = false
	prev_state = state
	state = get_state()
