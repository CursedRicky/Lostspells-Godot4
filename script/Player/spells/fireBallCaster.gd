extends Node2D
class_name PlayerCast

@export var bullet : PackedScene
@export var bullet_num: int = 1
@export_range(0,360) var arc: float = 0

@onready var cd = $"../Barre/hideOnPause/Panel5/Control/CD"
@onready var timer = $"../Barre/hideOnPause/Panel5/Control/Timer"
@onready var time = $"../Barre/hideOnPause/Panel5/Control/Time"
@onready var texture_rect = $"../Barre/hideOnPause/Panel5/Control/TextureRect"

func _ready():
	cd.max_value = timer.wait_time
	time.visible = false
	texture_rect.visible = false

func _process(delta):
	time.text = "%3.1f" % timer.time_left
	cd.value = timer.time_left
	if PlayerStats.mana >= 10:
		if Input.is_action_just_pressed("5"):
			shoot()
		texture_rect.visible = false
	else :
		texture_rect.visible = true
var canCast = true

func shoot():
	if canCast:
		canCast = false
		$".."._casting(10)
		timer.start()
		time.visible = true
		for i in bullet_num:
			$AudioStreamPlayer2D.play()
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


func _on_timer_timeout():
	canCast = true
	time.visible = false
