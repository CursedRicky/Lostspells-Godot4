extends Resource
class_name SpellInventory

signal updated

@export var slots: Array[SpellInventorySlot]

func insert(spell: SpellItem):
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = spell
			break
			
	updated.emit()
	
func removeItemAtIndex(index):
	slots[index] = SpellInventorySlot.new()

func insertSlot(index, inventorySlot: SpellInventorySlot):
	var oldIndex = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
