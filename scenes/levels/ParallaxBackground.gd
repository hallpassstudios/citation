extends ParallaxBackground

onready var layer_1 = $sun


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	layer_1.position.x += 100
