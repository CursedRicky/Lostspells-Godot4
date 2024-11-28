extends CharacterBody2D

@export var speed : int = 1
var dir = Vector2.RIGHT

func _ready():
	dir = Vector2.RIGHT.rotated(global_rotation)
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _process(delta):
	velocity = dir * speed
	var collision = move_and_collide(velocity)

func _on_screen_exited():
	queue_free()

