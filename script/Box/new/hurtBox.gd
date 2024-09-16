extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitbox") var hurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze)

func _on_area_entered(area):
	if area.is_in_group("Attack"):
		if not area.get("damage") == null:
			match hurtBoxType:
				0:
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1:
					pass
				2:
					if area.has_method("tempdisabled"):
						area.tempdisabled()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = area.knockback
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback") > 1:
				knockback = area.knockback
			var canCrit = area.canCrit
			var isMagic = area.isMagic
			var isToxic = area.isToxic
			var isPoison = area.isPoison
			var freeze = area.freeze
			emit_signal("hurt", damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze)


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
