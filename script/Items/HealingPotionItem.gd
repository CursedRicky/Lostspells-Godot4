extends Node2D

@onready var sprite = $Sprite2D2
@onready var animator = $Animator
var enter = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and enter:
		Global.healtPotion += 1
		queue_free()

func _on_animator_timeout():
	animation()

func animation():
	var tween = get_tree().create_tween()
	var yPos = sprite.position.y
	tween.set_parallel(false)
	tween.tween_property(sprite, "position:y", yPos - 4, 1)
	tween.tween_property(sprite, "position:y", yPos, 1)
	tween.tween_interval(2)

func _on_area_2d_area_entered(area):
	enter = true

func _on_area_2d_area_exited(area):
	enter = false
