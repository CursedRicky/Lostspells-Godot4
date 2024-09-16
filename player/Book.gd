extends CharacterBody2D
class_name Book

@export var target : Player = null

@onready var navigation_agent_2d = $NavigationAgent2D

var speed = 60

func _ready():
	call_deferred("seeker_setup")

func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position

func _physics_process(delta):
	
	if Global.casting :
		Global.casting = false
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.2)
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("OutCast")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("default")
	
	if target:
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()


func _on_area_2d_body_exited(body):
	if body is Player:
		global_position = target.global_position
