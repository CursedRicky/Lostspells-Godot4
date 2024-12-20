extends CharacterBody2D
class_name Goblino

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effectGoblin.tscn")

var speed = 30
var knockback= Vector2.ZERO
var playerIsInArea = false
var player
const MAXHEALT = 8
var healt = MAXHEALT

@onready var hurtBox = $HurtBox
@onready var hpBar = $HPBar
@onready var damageBar = $HPBar/DamageBar
@onready var damageTimer = $HPBar/Timer
@onready var origin = $Origin
@onready var navigation_agent_2d = $PathFinding/NavigationAgent2D
@export var target : Player

func _ready():
	hpBar.max_value = MAXHEALT
	hpBar.value = healt
	damageBar.max_value = MAXHEALT
	damageBar.value = healt
	hpBar.visible = false
	damageBar.visible = false

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	var dir = Vector2.ZERO
	if playerIsInArea and !Global.isInvisible:
		dir = navigation_agent_2d.get_next_path_position() - global_position
		dir = dir.normalized()
		$AnimatedSprite2D.play("walk")
		if position > player.position:
			$AnimatedSprite2D.flip_h = true
		else : 
			$AnimatedSprite2D.flip_h = false
		velocity = (knockback * delta + dir) * speed
		'''
		dir.x = round(dir.x)
		dir.y = round(dir.y)
		if dir == Vector2(0,1) :
			$AnimatedSprite2D.play("walkBot")
			$AnimatedSprite2D.flip_h = false
		if dir == Vector2(0,-1):
			$AnimatedSprite2D.play("walkTop")
			$AnimatedSprite2D.flip_h = false
		if dir == Vector2(1,0) or dir == Vector2(1,1):
			$AnimatedSprite2D.play("walkLeft")
			$AnimatedSprite2D.flip_h = true
		if dir == Vector2(-1,0) or dir == Vector2(-1,-1) :
			$AnimatedSprite2D.play("walkLeft")
			$AnimatedSprite2D.flip_h = false
		'''
		move_and_slide()
	else : 
		$AnimatedSprite2D.play("Idle")
		velocity = velocity / 2 * delta
	if healt <= .2 :
		PlayerStats.exp += randi_range(4,6)
		PlayerStats.souls+=1
		queue_free() 
		var enemyDeathEffect = EnemyDeathEffect.instantiate() 
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
	move_and_slide()

var inArea = false

func _on_hurt_box_area_entered(area):
	hpBar.visible = true #Rendi la barra degli Hp visibile solo dopo che il mob ha preso danno
	damageBar.visible = true
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
		dpsDamage(area)
	if Global.isInvisible:
		Global.isInvisible = false
	DamageNumber.dispay_number(damage, origin.global_position, crit)
	area.damage = areaD
	hpBar.value = healt #Aggiorna barra HP
	damageTimer.start()
	knockback = area.knockbackVector * 170
	hurtBox.createHitEffect()
	$Hit.play()
	$AnimationPlayer.play("Blink")

func dpsDamage(area):
	while inArea:
		healt -= area.damage

func _on_area_2d_body_entered(body):
	if body is Player :
		playerIsInArea = true
		player = body


func _on_area_2d_body_exited(body):
	if body is Player :
		playerIsInArea = false


func _on_timer_timeout():
	damageBar.value = healt


func _on_hurt_box_area_exited(area):
	inArea = false


func _on_path_timer_timeout():
	navigation_agent_2d.target_position = target.global_position
