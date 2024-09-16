extends "res://script/Box/hitBox.gd"

var knockbackVector = Vector2.ZERO
@onready var lightP = $"../PointLight2D"
@onready var timer = $"../../Barre/hideOnPause/Panel/Control/Timer"
@onready var CD = $"../../Barre/hideOnPause/Panel/Control/CD"
@onready var time = $"../../Barre/hideOnPause/Panel/Control/Time"
@onready var btn = $"../../Barre/hideOnPause/Panel/Control"
@onready var texture_rect = $"../../Barre/hideOnPause/Panel/Control/TextureRect"

var canCast = true

func _ready():
	$CollisionShape2D.disabled = true
	lightP.enabled = false
	CD.max_value = timer.wait_time
	time.visible = false
	texture_rect.visible = false

func _process(delta):
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left
	if PlayerStats.mana < 35:
		texture_rect.visible = true
	else :
		texture_rect.visible = false
	if canCast:
		if Input.is_action_just_pressed("1"):
			if PlayerStats.mana >= 35:
				Global.isInvisible = false
				timer.start()
				time.visible = true
				canCast = false
				Global.shake = true
				$CollisionShape2D.disabled = false
				lightP.enabled = true
				$"../../.."._casting(35)
				$"../AudioStreamPlayer2D".play()
				$"../GPUParticles2D".emitting = true
				await get_tree().create_timer(0.3).timeout
				Global.shake = false
				lightP.enabled = false
				$CollisionShape2D.disabled = true


func _on_timer_timeout():
	canCast = true
	time.visible = false
