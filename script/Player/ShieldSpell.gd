extends Node2D

var canCast = true
@onready var timer = $"../Barre/hideOnPause/Panel2/Control/Timer"
@onready var CD = $"../Barre/hideOnPause/Panel2/Control/CD"
@onready var time = $"../Barre/hideOnPause/Panel2/Control/Time"
@onready var texture_rect = $"../Barre/hideOnPause/Panel2/Control/TextureRect"


# Called when the node enters the scene tree for the first time.
func _ready():
	CD.max_value = timer.wait_time
	$Spell/Shield/AnimatedSprite2D.visible = false
	time.visible = false
	texture_rect.visible = false
	$AnimatedSprite2D.visible = false
	$Mirroring/CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left
	if PlayerStats.mana < 40:
		texture_rect.visible = true
	else :
		texture_rect.visible = false
	if canCast:
		if Input.is_action_just_pressed("2"):
			if PlayerStats.mana >= 40:
				timer.start()
				$ShieldTimer.start()
				$AnimatedSprite2D.play_backwards("break")
				$AnimatedSprite2D.visible = true
				time.visible = true
				$".."._casting(40)
				canCast = false
				PlayerStats.res += 1
				await $AnimatedSprite2D.animation_finished
				$AnimatedSprite2D.play("default")
				$Mirroring/CollisionShape2D.disabled = false

func _on_timer_timeout():
	time.visible = false
	canCast = true


func _on_shield_timer_timeout():
	PlayerStats.res -= 1
	$AnimatedSprite2D.play("break")
	$Mirroring/CollisionShape2D.disabled = true
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.visible = false
