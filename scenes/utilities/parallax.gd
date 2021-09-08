extends ParallaxBackground

onready var layer_1 = $sun
onready var layer_2 = $clouds
onready var layer_3 = $bunnies

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	layer_1.position += Vector2(0.07, 0)
	layer_2.position += Vector2(0.04,0)
	layer_3.position += Vector2(0.06,0)
	pass

