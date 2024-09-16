class_name InventorySlot
extends PanelContainer

@export var type : ItemDatas.Type



func init(t: ItemDatas.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms
	
func _can_drop_data(at_position, data):
	if data is InventoryItem:
		if type == ItemDatas.Type.MAIN:
			if get_child_count() == 0:
				return true
			else :
				if type == data.get_parent().type:
					return true
			return get_child(0).data.type == data.data.type
		else :
			return data.data.type == type
	return false
	
func _drop_data(at_position, data):
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent()) #Inverti gli oggetti
	data.reparent(self)
