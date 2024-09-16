extends CharacterBody2D

var isPlayerIn = false
@export var bossBar : ProgressBar
@onready var origin = $Origin
@export var damageBar : ProgressBar
@onready var hurtBox = $HurtBox
@onready var damage_timer = $DamageTimer
@export var bossName : Label
@onready var sprite_2d = $Sprite2D
@export var soul : PackedScene

var direction : Vector2

var healt = 50

func _process(delta):
	bossBar.visible = isPlayerIn
	direction = Global.player.position - position
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	else :
		sprite_2d.flip_h = false
		
	if healt <= 0:
		bossBar.visible = false
		find_child("FiniteStateMachine").change_state("Death")

func _ready():
	bossBar.max_value = healt
	bossBar.value = healt
	damageBar.max_value = healt
	damageBar.value = healt
	$Explosion/CollisionShape2D.disabled = true
	
func _on_area_2d_body_entered(body):
	if body is Player:
		isPlayerIn = true
		bossName.text = "Necromante"


func _on_area_2d_body_exited(body):
	if body is Player:
		isPlayerIn = false

var inArea = false

func _on_hurt_box_area_entered(area):
	var areaD = area.damage
	var damage = 0
	var crit = false
	area.damage *= randf_range(1, 1.5)
	var critN = randi_range(1, 100)
	if !area.dps:
		if Global.isInvisible:
			area.damage *= 1.5
		if area.canCrit and critN < PlayerStats.crit:
			crit = true
			damage = area.damage + area.damage * PlayerStats.critMult #Danno da critico 150%
			healt-=damage
		else :
			damage = area.damage #Mob prende danno
			healt-=damage
	else:
		inArea = true
		#dpsDamage(area)
	if Global.isInvisible:
		Global.isInvisible = false
	$Blink.play("blink")
	DamageNumber.dispay_number(damage, origin.global_position, crit)
	area.damage = areaD
	bossBar.value = healt #Aggiorna barra HP
	damage_timer.start()
	hurtBox.createHitEffect()

func _on_damage_timer_timeout():
	damageBar.value = healt

func _on_explosion_check_area_entered(area):
	$Explosion/ExplosionTimer.start()


func _on_explosion_timer_timeout():
	$Sprite2D/AnimatedSprite2D.play("default")
	await $Sprite2D/AnimatedSprite2D.animation_finished
	$Explosion/AudioStreamPlayer2D.play()
	$Explosion/GPUParticles2D.emitting = true
	$Explosion/CollisionShape2D.disabled = false
	await $Explosion/GPUParticles2D.finished
	$Explosion/CollisionShape2D.disabled = true

func spawn_loot():
	var soul = soul.instantiate()
	soul.global_position = global_position
	get_tree().root.call_deferred("add_child", soul)
