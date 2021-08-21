"""
This script / scene is specifically to check for orientation on the device and remind the user to change it
"""

extends Node

signal screen_orientation_changed(orientation)
const WINDOW_SIZE := OS.window_size

var platform : String
var screen_orientation : String

var paused
onready var panel = $"Orientation Check/Panel"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("screen orientation checker ready...")
	# get the mobile control button positions/size and store
	if OS.has_touchscreen_ui_hint():
		platform = "mobile"
		print("this is a mobile device or has a touchscreen")
	else:
		# assume we're in landscape already
		screen_orientation = "landscape"
		platform = "desktop"
		# panel.visible = false
		print("this is a desktop")

	# now check if we are in landscape and set that variable
	get_viewport().connect("size_changed", self, "_on_size_changed")
	if platform == "mobile":
		_on_size_changed()

func _process(delta):
	if screen_orientation == "portrait":
		panel.visible = true
		
	else: 
		panel.visible = false

func _on_size_changed():
	if platform == "desktop":
		return
	var s := OS.window_size
	if WINDOW_SIZE.x < s.x:
		emit_signal("screen_orientation_changed",  "landscape")
		screen_orientation = "landscape"
		get_tree().paused = false
		return   # somehow function triggers twice
	else:
		emit_signal("screen_orientation_changed",  "portrait")
		screen_orientation = "portrait"
		get_tree().paused = true
		return   # somehow function triggers twice
		
func _on_Control_screen_orientation_changed(orientation):
	screen_orientation = orientation
