extends Control

var isOpen = false
var canOpen = true

@export var hideOnPause : Control
@onready var spellInv: SpellInventory = preload("res://player/spellInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var ItemStackGuiClass = preload("res://UI/spellInventory/itemStackGui.tscn")
@export var blur : AnimationPlayer

var itemInHand: ItemStack

func _ready():
	spellInv.updated.connect(update)
	visible = false
	isOpen = false
	hideOnPause.visible = true
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
		if canOpen:
			if isOpen:
				close()
			else:
				open()

func open():
	visible = true
	isOpen = true
	hideOnPause.visible = false
	blur.play("blur")
	Global.canAttack = false
	Global.canMove = false
	Global.canRoll = false
	Global.cameraFollow = false

func close():
	visible = false
	isOpen = false
	hideOnPause.visible = true
	blur.play_backwards("blur")
	Global.canAttack = true
	Global.canMove = true
	Global.canRoll = true
	Global.cameraFollow = true
	
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
	itemInHand.scale = Vector2(.75, .75)
	


func _on_spell_inv_det_area_entered(area):
	canOpen = true


func _on_spell_inv_det_area_exited(area):
	canOpen = false
