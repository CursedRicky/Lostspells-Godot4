extends State

var can_transition 

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("hurt")
	await animation_player.animation_finished
	
	can_transition = true
	
func transition():
	if can_transition:
		get_parent().change_state("Summon")
