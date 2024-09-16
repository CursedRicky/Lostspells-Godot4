extends State

func enter():
	super.enter()
	owner.chase = false
	animation_player.play("Idle")
	
func transition():
	if owner.dir.length() <= 150:
		get_parent().change_state("Follow")
