class_name InventoryItem
extends TextureRect


@export var data: ItemDatas


func init(d: ItemDatas) -> void:
	data = d

func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	tooltip_text = "%s\n%s" % [data.name, data.description]

func _get_drag_data(at_position):
	set_drag_preview(make_drag_preview(at_position))
	return self
	
func make_drag_preview(at_position):
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	var c := Control.new()
	c.add_child(t)
	
	return c
