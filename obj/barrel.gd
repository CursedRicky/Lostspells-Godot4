extends StaticBody2D

var broken = false

func _on_hurt_box_hurt(damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze):
	if not broken:
		broken = true
		$AnimatedSprite2D.play("broken")
		$CollisionShape2D.disabled = true
