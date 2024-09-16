extends Node2D

var canCast = true
@onready var timer = $"../Barre/hideOnPause/Panel3/Control/Timer"
@onready var CD = $"../Barre/hideOnPause/Panel3/Control/CD"
@onready var time = $"../Barre/hideOnPause/Panel3/Control/Time"
@onready var texture_rect = $"../Barre/hideOnPause/Panel3/Control/TextureRect"


# Called when the node enters the scene tree for the first time.
func _ready():
	CD.max_value = timer.wait_time
	time.visible = false
	texture_rect.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time.text = "%3.1f" % timer.time_left
	CD.value = timer.time_left
	if PlayerStats.mana < 30 :
		texture_rect.visible = true
	else :
		texture_rect.visible = false
	if canCast:
		if Input.is_action_just_pressed("3"):
			if PlayerStats.mana >= 30 and PlayerStats.healt < PlayerStats.maxHealt:
				timer.start()
				time.visible = true
				$".."._casting(30)
				canCast = false
				$GPUParticles2D.emitting = true
				$AudioStreamPlayer2D.play()
				if (PlayerStats.healt + 20 > PlayerStats.maxHealt):
					PlayerStats.healt = PlayerStats.maxHealt
				else :
					PlayerStats.healt += 20
				$"..".healing()
				

func _on_timer_timeout():
	time.visible = false
	await get_tree().create_timer(0.1).timeout
	canCast = true
