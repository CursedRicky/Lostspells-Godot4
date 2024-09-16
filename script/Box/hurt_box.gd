extends Area2D

const HitEffect = preload("res://scenes/Enemy/hit_effect.tscn")

signal invincibilityStarted
signal invincibilityEnded

var invincible = false: set = setInvincible
@onready var timer = $Timer

func setInvincible(value):
	invincible = value
	if invincible:
		emit_signal("invincibilityStarted")
	else :
		emit_signal("invincibilityEnded")

func startInvincibility(duration):
	self.invincible = true
	timer.start(duration)
	
func createHitEffect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position - Vector2(0, 8)

func _on_timer_timeout():
	self.invincible = false

func _on_invincibility_started():
	set_deferred("monitorable", false)

func _on_invincibility_ended():
	monitorable = true
