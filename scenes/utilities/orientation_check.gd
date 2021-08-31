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
		platform = "desktop"
		print("this is a desktop")

func _process(delta):
	
	if OS.get_window_size().x < OS.get_window_size().y:
		screen_orientation = "portrait"
		panel.visible = true
	else: 
		panel.visible = false
