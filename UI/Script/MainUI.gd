extends Control

func _on_gioca_pressed():
	SceneTransition._scene_transition("res://rooms/roomsScene/spawningRoom.tscn")
	$AnimationPlayer.play("pulsanti")

func _on_exit_pressed():
	get_tree().quit()

func _ready():
	pass
	#$Name.text = "[wave amp=5 freq=4][color=#fff]" + "Lost Spells" + "[/color][/wave]"

func _on_comandi_pressed():
	pass # Replace with function body.


func _on_gioca_mouse_entered():
	$Selection.play()
	# $Sprite2D/CanvasLayer/Gioca.scale = Vector2(1.5, 1.5)

func _on_comandi_mouse_entered():
	$Selection.play()
	# $Sprite2D/CanvasLayer/Comandi.scale = Vector2(1.5, 1.5)

func _on_exit_mouse_entered():
	$Selection.play()
	# $Sprite2D/CanvasLayer/Exit.scale = Vector2(1.5, 1.5)

func _on_gioca_mouse_exited():
	$Sprite2D/CanvasLayer/Gioca.scale = Vector2(1, 1)

func _on_comandi_mouse_exited():
	$Sprite2D/CanvasLayer/Comandi.scale = Vector2(1, 1)

func _on_exit_mouse_exited():
	$Sprite2D/CanvasLayer/Exit.scale = Vector2(1, 1)
