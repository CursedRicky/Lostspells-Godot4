extends Node2D

var interactable: bool

@export var scene : String
@export var label : bool = false
@export var player : Player

func _ready():
	interactable = false

func _process(delta):
	if label:
		$Label.visible = interactable
	else :
		$Label.visible = false
	if Input.is_action_just_pressed("interact") :
		if interactable:
			_enter_home()
			
func _on_area_2d_area_entered(area):
	interactable = true


func _on_area_2d_area_exited(area):
	interactable = false


func _enter_home():
	label = false
	Global.canRain = false
	Global.coord = player.global_position
	player.canMove = false
	SceneTransition._scene_transition(scene)
	
	
