extends State

func _on_player_det_body_entered(body):
	if body is Player:
		get_parent().change_state("Summon")
