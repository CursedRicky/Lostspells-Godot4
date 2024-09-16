extends SpellItem

@export var heal_increase: int = 1

func use(player: Player):
	player.healingSpell(heal_increase, manaCost)
