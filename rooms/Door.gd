extends StaticBody2D

var opened = false

func open():
	opened = true
	$Lock.play()
	$Door.play("Opening")
	sound()
	await $Door.animation_finished
	$CollisionShape2D.disabled = true
	$Door.play("Opened")
	
func sound():
	$Open.play()

func _on_area_2d_body_entered(body):
	if body is Player:
		if Global.key >= 1:
			Global.key -= 1
			if not opened:
				open()
