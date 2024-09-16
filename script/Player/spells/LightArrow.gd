extends CharacterBody2D

@export var speed : int = 1
var dir = Vector2.RIGHT

func _ready():
	dir = Vector2.RIGHT.rotated(global_rotation)
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("start")

func _on_screen_exited():
	queue_free()

func _process(delta):
	velocity = dir * speed
	var collision = move_and_collide(velocity)
	if collision:
		destroy()

func _on_mirroring_area_area_entered(area):
	dir = Vector2(-dir.x, -dir.y)
	$AnimatedSprite2D.flip_h = true
	$CollisionShape2D.position = -$CollisionShape2D.position
	$hitBox/CollisionShape2D.position = -$hitBox/CollisionShape2D.position
	$"Mirroring Area/CollisionShape2D".position = -$"Mirroring Area/CollisionShape2D".position
	$hitBox2/CollisionShape2D.disabled = false

func destroy():
	$AnimatedSprite2D.play("explode")
	$hitBox/CollisionShape2D.disabled = true
	speed = 0
	await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_area_2d_body_entered(body):
	destroy()

func _on_hurt_box_hurt(damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze):
	destroy()

func _on_timer_timeout():
	destroy()
