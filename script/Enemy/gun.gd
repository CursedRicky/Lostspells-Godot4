extends Node2D
class_name Gun

@export var bullet : PackedScene
@export var bullet_num: int = 1
@export_range(0,360) var arc: float = 0
@export_range(0,20) var fire_rate: float = 2.0

var can_shoot = true

func _process(delta):
	pass

func shoot():
	if can_shoot:
		can_shoot = false
		for i in bullet_num:
			var new_bullet = bullet.instantiate()
			new_bullet.global_position = global_position
			if bullet_num == 1:
				new_bullet.rotation = global_rotation
			else :
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_num - 1)
				new_bullet.global_rotation = (
					global_rotation +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
			await get_tree().create_timer(1 / fire_rate).timeout
			can_shoot = true
