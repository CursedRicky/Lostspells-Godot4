extends CanvasLayer

var current_scene = null
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
func _scene_transition(target: String) -> void:
	call_deferred("switch_scene", target)
	
func switch_scene(target: String) -> void:
	Global.canPause = false
	get_tree().paused = true
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	current_scene.free()
	var s = load(target)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	$AnimationPlayer.play_backwards("dissolve")
	Global.canPause = true
	get_tree().paused = false
