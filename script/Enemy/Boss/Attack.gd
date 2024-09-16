extends State

@onready var gun = $"../../Gun"
var can_transition : bool

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("ranged_attack")
	await animation_player.animation_finished
	
	can_transition = true
	
func transition():
	if can_transition:
		can_transition = false
		if (randi_range(1,2) == 1) :
			get_parent().change_state("Summon")
		else :
			enter()
		
func shoot():
	var angle_to_player = global_position.direction_to(Global.player.position).angle()
	gun.rotation = angle_to_player
	gun.shoot()
