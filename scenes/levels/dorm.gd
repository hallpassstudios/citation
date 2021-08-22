extends Node2D

var camera = preload("res://scenes/utilities/camera.tscn")
var player = preload("res://scenes/player/top_down_player.tscn")
onready var player_spawn = $"player spawn"

# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn camera
	#camera = camera.instance()
	#add_child(camera)
	
	#spawn player
	player = player.instance()
	add_child(player)
	globals.player = player
	player.position = player_spawn.position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_interactables_mouse_entered():
	print("mouse")
