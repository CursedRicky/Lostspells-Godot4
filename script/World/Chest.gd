extends Node2D

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@export var lootTableScene : PackedScene

var lootable = false
var enter = false

@onready var player = $"../Player"
@onready var interaction_area = $InteractionArea
@onready var label = $Label

@export var labelV : bool = false

func _ready(): 
	animationTree.active = true
	animationState.travel("Idle")
	label.visible = false

func openChest():
	animationState.travel("Opening")
	
func giveItemsToPlayer() :
	var gold = randi_range(1, 3)
	var mult = randi_range(5, 10)
	PlayerStats.gold += gold * mult
	lootTableScene.instantiate()
	
func _process(delta):
	if !lootable:
		label.visible = enter and labelV
	else :
		label.visible = false
	
	if enter:
		if Input.get_action_raw_strength("interact") :
			if !lootable:
				openChest()
				lootable = true

func _on_area_2d_area_entered(area):
	enter = true


func _on_area_2d_area_exited(area):
	enter = false
