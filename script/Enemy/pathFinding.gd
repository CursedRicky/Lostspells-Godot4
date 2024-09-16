extends Node2D
class_name PathFinding

@onready var navigation_agent_2d = $NavigationAgent2D
@export var target : Player
var dir = Vector2.ZERO

func _ready():
	update_target()
	
func update_target():
	navigation_agent_2d.target_position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	update_target()
	dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()

