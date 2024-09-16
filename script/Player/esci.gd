extends Node2D

@export var player : Player

func _on_area_2d_body_entered(body):
	Global.canRain = true
	player.canMove = false
	Global.playerEsce = true
	SceneTransition._scene_transition("res://scenes/Main.tscn")
