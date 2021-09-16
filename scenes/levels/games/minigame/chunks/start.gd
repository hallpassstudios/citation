extends Node2D

export var speed = 5
var on_screen
onready var spawn = $spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	global_ui.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position.y += speed * delta
	pass

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	print("viewport entered")
	on_screen = true

func _on_VisibilityNotifier2D_screen_entered():
	print("screen entered")

func _on_VisibilityNotifier2D_screen_exited():
	print("screen exited")

func _on_exit_body_entered(body):
	if body.name == "top down runner":
		global_ui.fade_out()
		print("going to next level...")
		get_tree().get_root().get_node("main").goto("0")
