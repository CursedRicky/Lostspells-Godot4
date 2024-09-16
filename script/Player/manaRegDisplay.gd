extends Control

func _process(delta):
	$Label.text = str(PlayerStats.manaRegen)
