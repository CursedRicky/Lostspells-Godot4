extends Resource
class_name SpellInventory

signal updated
signal use_spell

@export var slots: Array[SpellInventorySlot]

func insert(spell: SpellItem):
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = spell
			break
	updated.emit()
	
func removeItemAtIndex(index):
	slots[index] = SpellInventorySlot.new()
	updated.emit()

func insertSlot(index, inventorySlot: SpellInventorySlot):
	var oldIndex = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
	updated.emit()
	
func use_spell_at_index(index: int):
	if index < 0 || index >= slots.size() || !slots[index]: return
	var slot = slots[index]
	use_spell.emit(slot.item)
