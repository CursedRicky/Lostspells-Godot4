extends Resource
class_name SpellItem

@export var name: String = ""
@export var damageDescription: String = ""
@export var buff0: String = ""
@export var buff1: String = ""
@export var texture: Texture2D
@export var cd: int

enum Rarities {
	Common,
	Uncommon,
	Rare,
	Epic,
	Leggendary
}

@export var rarity : Rarities

@export var manaCost: int = 10
@export var healtCost: int = 0

@export var isAHealing: bool = false

func use(player: Player):
	pass
