extends Node

enum gameStates {
	PLAYING,
	PAUSED
}

# our background loading
var loader
var wait_frames
var time_max = 100 # msec
var current_scene

# our player
var player
var tutorial_played = false
var player_name : String
var player_type : Object
var player_spawn : int = 0
var is_lit = false
var illuminata_completed = false
var can_shoot = false
var read_everything = false


# save / load 


# connect up to high-score DB
var platform : String
var screen_orientation : String
var right_button
var jump_button

# player vars
var player_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		print("found player: ", player)
	# scene management
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func set_player(current_player):
	player = current_player
	print("globals: setting current player to: ", current_player)

# progressive scene loading
func goto_scene(path): # Game requests to switch to this scene.
	print("loading new level: ", path)
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # Check for errors.
		print("no loader when calling new scene")
		return
	set_process(true)

	current_scene.queue_free() # Get rid of the old scene.

	# Start your "loading..." animation.
	# get_node("animation").play("loading")
	wait_frames = 1

func _process(delta):

	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	# Wait for frames to let the "loading" animation show up.
	if wait_frames > 0:
		wait_frames -= 1
		return
		
	var t = OS.get_ticks_msec()
	# Use "time_max" to control for how long we block this thread.
	while OS.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # Error during loading.
			# show_error()
			loader = null
			break

# our loading animation
func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# Update your progress bar?
	# get_node("progress").set_progress(progress)

	# ...or update a progress animation?
	# var length = get_node("animation").get_current_animation_length()

	# Call this on a paused animation. Use "true" as the second argument to
	# force the animation to update.
	# get_node("animation").seek(progress * length, true)

# calling a new scene
func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
