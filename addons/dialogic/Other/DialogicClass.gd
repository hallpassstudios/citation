extends Node

## Exposed and safe to use methods for Dialogic
## See documentation here:
## https://github.com/coppolaemilio/dialogic

## ### /!\ ###
## Do not use methods from other classes as it could break the plugin's integrity
## ### /!\ ###
##
## Trying to follow this documentation convention: https://github.com/godotengine/godot/pull/41095
class_name Dialogic


## Refactor the start function for 2.0 there should be a cleaner way to do it :)

## Starts the dialog for the given timeline and returns a Dialog node.
## You must then add it manually to the scene to display the dialog.
##
## Example:
## var new_dialog = Dialogic.start('Your Timeline Name Here')
## add_child(new_dialog)
##
## This is exactly the same as using the editor:
## you can drag and drop the scene located at /addons/dialogic/Dialog.tscn 
## and set the current timeline via the inspector.
##
## @param timeline				The timeline to load. You can provide the timeline name or the filename.
## @param reset_saves			True to reset dialogic saved data such as definitions.
## @param dialog_scene_path		If you made a custom Dialog scene or moved it from its default path, you can specify its new path here.
## @param debug_mode			Debug is disabled by default but can be enabled if needed.
## @param use_canvas_instead	Create the Dialog inside a canvas layer to make it show up regardless of the camera 2D/3D situation.
## @returns						A Dialog node to be added into the scene tree.
static func start(timeline: String, reset_saves: bool=false, dialog_scene_path: String="res://addons/dialogic/Dialog.tscn", debug_mode: bool=false, use_canvas_instead=true):
	var dialog_scene = load(dialog_scene_path)
	var dialog_node = null
	var canvas_dialog_node = null
	var returned_dialog_node = null
	
	if use_canvas_instead:
		var canvas_dialog_script = load("res://addons/dialogic/Nodes/canvas_dialog_node.gd")
		canvas_dialog_node = canvas_dialog_script.new()
		canvas_dialog_node.set_dialog_node_scene(dialog_scene)
		dialog_node = canvas_dialog_node.dialog_node
	else:
		dialog_node = dialog_scene.instance()
	
	dialog_node.reset_saves = reset_saves
	dialog_node.debug_mode = debug_mode
	
	returned_dialog_node = dialog_node if not canvas_dialog_node else canvas_dialog_node
	
	var timelines = DialogicUtil.get_full_resource_folder_structure()['folders']['Timelines']
	var parts = timeline.split('/', false)
	if parts.size() > 1:
		var current_data
		var current_depth = 0
		for p in parts:
			if current_depth == 0:
				# Starting the crawl
				current_data = timelines['folders'][p]
			elif current_depth == parts.size() - 1:
				# The final destination
				for t in DialogicUtil.get_timeline_list():
					for f in current_data['files']:
						if t['file'] == f && t['name'] == p:
							dialog_node.timeline = t['file']
							return returned_dialog_node
			else:
				# Still going deeper
				current_data = current_data['folders'][p]
			current_depth += 1
	else:
		# Searching for any timeline that could match that name
		for t in DialogicUtil.get_timeline_list():
			if parts.size():
				if t['name'] == parts[0]:
					dialog_node.timeline = t['file']
					return returned_dialog_node

		# No file found. Show error
		dialog_node.dialog_script = {
			"events":[
				{"event_id":'dialogic_001',
				"character":"",
				"portrait":"",
				"text":"[Dialogic Error] Loading dialog [color=red]" + timeline + "[/color]. It seems like the timeline doesn't exists. Maybe the name is wrong?"
			}]
		}
		return returned_dialog_node

	# Just in case everything else fails.
	return returned_dialog_node


## Same as the start method above, but using the last timeline saved.
## 
## @param timeline              The current timeline to load
## @param initial_timeline		The timeline to load in case no save is found.
## @param dialog_scene_path		If you made a custom Dialog scene or moved it from its default path, you can specify its new path here.
## @param debug_mode			Debug is disabled by default but can be enabled if needed.
## @returns						A Dialog node to be added into the scene tree.
static func start_from_save(timeline: String, initial_timeline: String, dialog_scene_path: String="res://addons/dialogic/Dialog.tscn", debug_mode: bool=false):
	var current = timeline
	if current.empty():
		current = initial_timeline
	return start(current, false, dialog_scene_path, debug_mode)
