extends Panel

@onready var inventory: SpellInventory = preload("res://player/spellInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var selected_slot: int = 0

func _ready():
	inventory.updated.connect(updateH)
	updateH()

func updateH():
	for i in range(slots.size()):
		var inventory_slot: SpellInventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)

func _unhandled_input(event):
	if event.is_action_pressed("useSpell") and inventory.slots[selected_slot].item and slots[selected_slot].canCast:
		if inventory.slots[selected_slot].item.manaCost <= PlayerStats.mana and inventory.slots[selected_slot].item.healtCost < PlayerStats.healt:
			if inventory.slots[selected_slot].item.isAHealing and PlayerStats.healt == PlayerStats.maxHealt: return
			inventory.use_spell_at_index(selected_slot)
			slots[selected_slot].timer.start()
			slots[selected_slot].time.visible = true
			slots[selected_slot].canCast = false
	
	if event.is_action("move_selector_down"):
		move_selector(-1)
	
	if event.is_action("move_selector_up"):
		move_selector(1)
		
func move_selector(value):
	selected_slot = (selected_slot + value) % slots.size()
	selector.global_position = slots[selected_slot].global_position
	if selected_slot == -2:
		selected_slot = 1
	elif selected_slot == -1:
		selected_slot = 2
