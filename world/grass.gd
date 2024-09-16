extends Node2D

@onready var sprite = $Grass

var rot = randi_range(20,30)
var playerIn = false

func ready():
	$Animator.wait_time = randf_range(2,3)
	animate()

func _process(delta):
	pass

func animate():
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property(sprite, "rotation_degrees", rot, 1)
	tween.tween_property(sprite, "rotation_degrees", 0, 1)
	tween.tween_interval(2)

func _on_animator_timeout():
	animate()

func _on_area_2d_body_entered(body):
	playerIn = true
	rot = 24

func _on_area_2d_body_exited(body):
	playerIn = false
	animate()
	rot = -24
