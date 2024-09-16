extends StaticBody2D

var active = true
var inArea = false

@onready var keyScene = preload("res://rooms/goldenKey.tscn")

const lines = [
	"Welcome, wizard.",
	"I am Isolde, the guardian of this dungeon.",
	"I am here to guide you… and to test your worth.",
	"Be wise and prepare for what is to come.",
	"The key awaits you."
]

func _on_area_2d_body_entered(body):
	inArea = true
	if active:
		DialogueMenager.start_dialogue(global_position, lines)
		DialogueMenager.complete.connect(dialogueFin)
		active = false

func _on_area_2d_body_exited(body):
	inArea = false

func dialogueFin():
	$AnimationPlayer.play("shade_out")
	await $AnimationPlayer.animation_finished
	var key = keyScene.instantiate()
	get_tree().root.add_child(key)
	key.global_position = global_position
	DialogueMenager.complete.disconnect(dialogueFin)
	queue_free()
