extends State

func enter():
	super.enter()
	owner.chase = true
	owner.set_physics_process(true)
	animation_player.play("Move")
	
func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	if owner.dir.length() > 150:
		get_parent().change_state("Moving")
	if owner.dir.length() <= 20:
		get_parent().change_state("Attack")
