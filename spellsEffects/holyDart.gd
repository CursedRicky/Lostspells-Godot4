extends SpellItem

func use(player: Player):
	player.holyDart(manaCost)
