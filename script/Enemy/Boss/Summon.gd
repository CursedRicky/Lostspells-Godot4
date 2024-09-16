extends State

@onready var spirit_node = load("res://scenes/Enemy/Mobs/spirit.tscn")
@onready var ghost_node = load("res://scenes/Enemy/Mobs/ghost.tscn")
var can_transition : bool

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("summon")
	await animation_player.animation_finished
	
	can_transition = true
	
func spawn():
	if (randi_range(1,2) == 1) :
		var spirit = spirit_node.instantiate()
		spirit.target = player
		if (randi_range(1,2) == 1) :
			spirit.position = global_position + Vector2(40,40)
		else :
			spirit.position = global_position + Vector2(-40,-40)
		get_tree().current_scene.call_deferred("add_child", spirit)
	else :
		var ghost = ghost_node.instantiate()
		ghost.target = player
		ghost.position = global_position + Vector2(40,40)
		get_tree().current_scene.call_deferred("add_child", ghost)

func transition():
	if can_transition:
		get_parent().change_state("Attack")
