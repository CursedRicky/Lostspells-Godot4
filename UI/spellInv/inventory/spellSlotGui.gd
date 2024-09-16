extends Button

@onready var container = $CenterContainer

@onready var spellInventory = preload("res://spells/spell_inv.tres")

var itemStackGui : ItemStack
var index: int

func insert(isg: ItemStack):
	itemStackGui = isg
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || spellInventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	spellInventory.insertSlot(index, itemStackGui.inventorySlot)
	
func takeItem():
	var item = itemStackGui
	
	container.remove_child(itemStackGui)
	itemStackGui = null
	
	return item
	
func isEmpty():
	return !itemStackGui
