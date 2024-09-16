extends "res://script/Box/hitBox.gd"

var knockbackVector = Vector2.ZERO

@export var player : Player

func _ready():
	$CollisionShape2D.disabled = true

func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		if PlayerStats.mana >= 50:
			global_position = get_global_mouse_position()
			player._casting(50)
			$CollisionShape2D.disabled = false
			$GPUParticles2D2.emitting = true
			Global.shake = true
			$AudioStreamPlayer2D.play()
			await get_tree().create_timer(0.3).timeout
			Global.shake = false
			$CollisionShape2D.disabled = true
