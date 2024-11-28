extends Node2D

var enter = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$hitBox/CollisionShape2D.disabled = true

func _process(delta):
	if enter:
		$AnimationPlayer.play("active")
	else :
		$AnimationPlayer.play("defualt")

func damage():
	$hitBox/CollisionShape2D.disabled = false

func disabled():
	$hitBox/CollisionShape2D.disabled = true

func _on_area_2d_body_entered(body):
	if body is Player:
		enter = true

func _on_area_2d_body_exited(body):
	if body is Player:
		enter = false

func randPitch():
	$AudioStreamPlayer2D.pitch_scale = randf_range(.8, 1.2)
