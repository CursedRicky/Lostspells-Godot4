extends CharacterBody2D

@export var speed : int = 1
var dir = Vector2.RIGHT

func _ready():
	dir = Vector2.RIGHT.rotated(global_rotation)

func _on_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = dir * speed
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()

func _on_area_2d_area_entered(area):
	queue_free()

func _on_area_2d_area_exited(area):
	queue_free()

func _on_mirroring_area_area_entered(area):
	dir = Vector2(-dir.x, -dir.y)
	$AnimatedSprite2D.flip_h = true
	$CollisionShape2D.position = -$CollisionShape2D.position
	$hitBox/CollisionShape2D.position = -$hitBox/CollisionShape2D.position
	$"Mirroring Area/CollisionShape2D".position = -$"Mirroring Area/CollisionShape2D".position
	$hitBox2/CollisionShape2D.disabled = false
