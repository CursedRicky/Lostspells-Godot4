extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.pitch_scale = randf_range(.9, 1.1)

