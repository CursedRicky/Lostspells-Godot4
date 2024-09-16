extends CanvasLayer

var InvSize = 20

@export var player : Player

func _ready():
	self.visible = false
	for i in InvSize:
		var slot := InventorySlot.new()
		slot.init(ItemDatas.Type.MAIN, Vector2(25, 25))
		%Inv.add_child(slot)
		
	
	for y in Global.itemsLoad.size():
		var item := InventoryItem.new()
		item.init(load(Global.itemsLoad[y]))
		%Inv.get_child(y).add_child(item)
	

func _process(delta):
	$Crit.text = str(PlayerStats.crit) + "%"
	$Mana.text = str(PlayerStats.maxMana)
	$Coins.text = str(PlayerStats.gold)
	
	if Input.is_action_just_pressed("inventory"):
		Global.isInventoryOpen = !Global.isInventoryOpen
		if Global.isInventoryOpen and Input.is_action_just_pressed("Esci"):
			self.visible = false
		elif Global.isInventoryOpen:
			self.visible = false
			player.canMove = true
		else:
			self.visible = true
			player.canMove = false
	
