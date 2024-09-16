extends TextureButton
class_name SkillNode

@onready var panel = $Panel
@onready var line_2d = $Line2D

func _ready():
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size / 2)
		line_2d.add_point(get_parent().global_position + size/2)

func _on_pressed():
	if PlayerStats.skillPoint > 0:
		panel.show_behind_parent = true
		PlayerStats.skillPoint -= 1
