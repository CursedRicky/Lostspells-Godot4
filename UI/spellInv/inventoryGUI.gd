extends Control

var isOpen = false

@onready var spellInv: SpellInventory = preload("res://spells/spell_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var ItemStackGuiClass = preload("res://itemStackGui.tscn")

var itemInHand: ItemStack

func _ready():
	spellInv.updated.connect(update)
	close()
	update()
	connectSlots()

func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(slotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(spellInv.slots.size(), slots.size())):
		var inventorySlot: SpellInventorySlot = spellInv.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui : ItemStack = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
			
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func _input(event):
	updateItemInHand()
	if event.is_action_pressed("spellInventory"):
		if isOpen:
			close()
		else:
			open()

func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
	
func slotClicked(slot):
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
	
	if !itemInHand:
		takeItemFromSlot(slot)
	
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	
