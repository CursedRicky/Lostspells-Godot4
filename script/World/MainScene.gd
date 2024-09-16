class_name MainScene extends Node2D

@export var player: Player

func _process(delta):
	if Global.playerEsce:
		player.global_position = Global.coord
		Global.playerEsce = false
		player.canMove = true
		
		
