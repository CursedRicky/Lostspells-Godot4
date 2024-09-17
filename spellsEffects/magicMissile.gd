extends SpellItem

func use(player: Player):
	player.magicMissileSpell(manaCost)
