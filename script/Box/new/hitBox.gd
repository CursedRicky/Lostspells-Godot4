extends Area2D

@export var damage = 1
@export var canCrit = false
@export var isMagic = false
@export var isToxic = false
@export var isPoison = false
@export var freeze = false
@export var knockback = 1
@onready var collission = $CollisionShape2D
@onready var disableTimer = $DisableHitBoxTimer
@onready var angle = self.global_position

func _process(delta):
	angle = self.global_position

func tempdisabled():
	collission.call_deferred("set", "disabled", true)
	disableTimer.start()


func _on_disable_hit_box_timer_timeout():
	collission.call_deferred("set", "disabled", false)
