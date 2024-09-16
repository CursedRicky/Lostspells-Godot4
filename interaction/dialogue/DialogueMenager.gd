extends Node

@onready var text_box_scene = preload("res://interaction/dialogue/text_bow.tscn")

var dialogue_lines = []
var current_line_index = 0

var text_box
var text_box_position

var is_dialogue_active = false
var can_advance_line = false

signal dialogue_finished
signal complete

func start_dialogue(position, lines):
	if is_dialogue_active:
		return
		
	dialogue_lines = lines
	text_box_position = position
	_show_text_bow()
	
	is_dialogue_active = true
	
func _show_text_bow():
	text_box = text_box_scene.instantiate()
	text_box.finish_displaying.connect(_on_text_box_finished_display)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialogue_lines[current_line_index])
	can_advance_line = false
	
func _on_text_box_finished_display():
	can_advance_line = true
	
func _unhandled_input(event):
	if (event.is_action_pressed("dialogue") and is_dialogue_active and can_advance_line):
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			complete.emit()
			return
		_show_text_bow()
