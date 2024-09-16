extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hurt_box_hurt(damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze):
	$AnimatedSprite2D.play("breaking")
	await $AnimatedSprite2D.animation_finished
	queue_free()
