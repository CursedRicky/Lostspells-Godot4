extends AnimatedSprite2D

func _ready():
	self.connect("animation_finished",Callable(self, "_on_animation_finished"))
	frame = 0
	play("Animate")

func _on_animation_finished():
	queue_free()
