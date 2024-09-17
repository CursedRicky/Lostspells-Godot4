extends AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.set("shader_parameter/selector",Global.selectorValue);
