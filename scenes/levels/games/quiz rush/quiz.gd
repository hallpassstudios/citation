extends Node2D

onready var light = $light
var light_charge = 0

func _ready():
	$light.get_child(0).self_modulate = Color(1,1,0,light_charge)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if light_charge >= 0:
		$light.get_child(0).self_modulate = Color(1,1,0,light_charge)

func _on_Area2D_body_entered(body):
	if body.name == "player":
		print("player entered")
		if get_parent().correct:
			# answer is correct, so we increase the score
			globals.player_score += 1
