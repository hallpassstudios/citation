extends Node2D

export(bool) var correct
var colliding : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if colliding:
		if correct:
			globals.player_score += 1
			get_parent().light_charge += .001
		else:
			if globals.player_score > 0:
				globals.player_score -= 1
				get_parent().light_charge -= .001


func _on_Area2D_body_entered(body):
	if body.name == "player":
		colliding = true
			


func _on_Area2D_body_exited(body):
	if body.name == "player":
		colliding = false
			
