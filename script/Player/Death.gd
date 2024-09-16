extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_pressed():
	SceneTransition._scene_transition("res://UI/MainUI.tscn")
	Global.death = false
	PlayerStats.healt = PlayerStats.maxHealt
