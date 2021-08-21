extends CanvasLayer

onready var page_1 = $"1"
onready var paused = get_node("/root/paused")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("showing tutorial")
	page_1.visible = true

func _on_1_pressed():
	print("starting game")
	get_tree().paused = false
	queue_free()
