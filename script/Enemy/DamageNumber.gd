extends Node


func dispay_number(value: float, position: Vector2, is_crit : bool = false, is_magic : bool = false, is_poison : bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(round_to_dec(value, 1))
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_crit:
		color = "#B22"
	elif is_magic:
		color = "#009ddc"
	elif is_poison:
		color = "#702d5a"
	if value == 0:
		color = "#FFF8"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 16
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	number.label_settings.font = load("res://art/Font/font1.ttf")
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, .35
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, .35
	).set_ease(Tween.EASE_IN).set_delay(.35)
	tween.tween_property(
		number, "scale", Vector2.ZERO, .35
	).set_ease(Tween.EASE_IN).set_delay(.35)
	
	await tween.finished
	number.queue_free()
	
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
