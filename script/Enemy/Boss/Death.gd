extends State

func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	animation_player.play("boss_slained")
