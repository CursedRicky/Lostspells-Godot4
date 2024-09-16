extends Button

@onready var container = $CenterContainer

@onready var spellInventory = preload("res://player/spellInventory.tres")

var itemStackGui : ItemStack
var index: int
var rarity

func _ready():
	$Info.visible = false

func insert(isg: ItemStack):
	itemStackGui = isg
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || spellInventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	spellInventory.insertSlot(index, itemStackGui.inventorySlot)
	display()
	
func takeItem():
	var item = itemStackGui
	container.remove_child(itemStackGui)
	itemStackGui = null
	$Info.visible = false
	return item
	
func isEmpty():
	return !itemStackGui

enum Rarities {
	Common,
	Uncommon,
	Rare,
	Epic,
	Leggendary
}

func display():
	$Info.visible = true
	$Info/Name.text = itemStackGui.inventorySlot.item.name
	$Info/Damage.text = itemStackGui.inventorySlot.item.damageDescription
	$Info/Buff0.text = itemStackGui.inventorySlot.item.buff0
	$Info/Buff1.text = itemStackGui.inventorySlot.item.buff1
	var rarity = itemStackGui.inventorySlot.item.rarity
	match rarity:
		Rarities.Common:
			$Info/Name.text = "[wave amp=5 freq=.1][color=#c3c3c3]" + itemStackGui.inventorySlot.item.name + "[/color][/wave]"
		Rarities.Uncommon:
			$Info/Name.text = "[wave amp=5 freq=1][color=#15b141]" + itemStackGui.inventorySlot.item.name + "[/color][/wave]"
		Rarities.Rare:
			$Info/Name.text = "[wave amp=5 freq=2][color=#00a8f3]" + itemStackGui.inventorySlot.item.name + "[/color][/wave]"
		Rarities.Epic:
			$Info/Name.text = "[wave amp=5 freq=3][color=#b83dba]" + itemStackGui.inventorySlot.item.name + "[/color][/wave]"
		Rarities.Leggendary:
			$Info/Name.text = "[wave amp=5 freq=4][color=#ffca18]" + itemStackGui.inventorySlot.item.name + "[/color][/wave]"

func _on_mouse_entered():
	if itemStackGui:
		display()
		# Popups.ItemPopup(itemStackGui.inventorySlot.item, global_position)


func _on_mouse_exited():
	if itemStackGui:
		$Info.visible = false
		# Popups.HideItemPopup()
