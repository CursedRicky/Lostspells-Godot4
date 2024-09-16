extends Panel

class_name ItemStack

@onready var sprite = $Sprite

var inventorySlot: SpellInventorySlot

func update():
	if !inventorySlot || !inventorySlot.item: return
	
	sprite.visible = true
	sprite.texture = inventorySlot.item.texture
