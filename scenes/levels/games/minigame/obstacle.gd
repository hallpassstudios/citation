extends Node2D

onready var obstacle = preload("res://sprites/environment/lounge/plant1.png")

var speed = 0

func _process(delta):
	position.x -= speed * delta

func _on_Area2D_body_entered(body):
	if body.name == "runner":
		# restart the level for now
		get_tree().reload_current_scene()
