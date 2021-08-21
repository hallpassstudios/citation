extends Node2D

onready var alert_label = $"Alert Layer/Label"

onready var fade_animation_player = $"Fade Layer/AnimationPlayer"
onready var alert_animation_player = $"Fade Layer/AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("global ui loaded...")

func fade_out():
	fade_animation_player.play("Fade Out")
	print("fading out")

func fade_in():
	fade_animation_player.play("Fade In")
	print("fading in")
