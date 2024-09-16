extends Button

@onready var itemStackGui : ItemStack = $CenterContainer/Panel
@onready var timer = $Timer
@onready var CD = $CD
@onready var time = $Time
var canCast = true

func update_to_slot(slot: SpellInventorySlot):
	if !slot.item:
		itemStackGui.visible = false
		return
	itemStackGui.inventorySlot = slot
	itemStackGui.update()
	itemStackGui.visible = true
	timer.wait_time = itemStackGui.inventorySlot.item.cd
	
func _ready():
	time.visible = false
	
func _process(delta):
	CD.max_value = timer.wait_time
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left

func _on_timer_timeout():
	time.visible = false
	canCast = true
