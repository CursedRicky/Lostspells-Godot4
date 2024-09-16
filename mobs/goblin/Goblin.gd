extends CharacterBody2D
class_name Goblins

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effectBat.tscn")

@export var maxSpeed = 50
var speed = maxSpeed
var playerIsInArea = false
@export var MAXHEALT = 100
var healt = MAXHEALT
var knockbackRecovery = 3.5
var knockback = Vector2.ZERO
var poisonDot = 3
var isPoisoned = false
var isAttacking = false

var freezed = false

var chase = false
var canChase = false

@onready var hurtBox = $HurtBox
@onready var hpBar = $HPBar
@onready var damageBar = $HPBar/DamageBar
@onready var damageTimer = $HPBar/Timer
@onready var origin = $Origin
var target = null
var start_pos

var dir = Vector2.ZERO
var movingDir = Vector2.ZERO

func _ready():
	randomize()
	$Sprite.play("def")
	$swordHitBox/CollisionShape2D.disabled = true
	$Blink.play("RESET")
	start_pos = position
	$Bar.visible = false
	hpBar.max_value = MAXHEALT
	hpBar.value = healt
	damageBar.max_value = MAXHEALT
	damageBar.value = 0
	hpBar.visible = false
	damageBar.visible = false
	target = Global.player
	$Poison.visible = false
	
func _physics_process(delta):
	pass

func _process(delta: float):
	knockback = knockback.move_toward(Vector2.ZERO, knockbackRecovery)
	dir = target.global_position - global_position
	if not freezed:
		canChase = !$RayCast2D.is_colliding()
		if playerIsInArea and canChase:
			if dir != Vector2(0,0) and not isAttacking:
				$Sprite.play("Move")
			if dir.x < 0:
				$Sprite2D.flip_h = true
			else : 
				$Sprite2D.flip_h = false
		elif not isAttacking:
			if movingDir != Vector2(0,0):
				$Sprite.play("Move")
			else :
				$Sprite.play("Idle")
			if movingDir.x < 0:
				$Sprite2D.flip_h = true
			else : 
				$Sprite2D.flip_h = false
	if chase and canChase:
		velocity = (knockback * delta + dir.normalized()) * speed
	else: 
		velocity = (knockback * delta + movingDir.normalized()) * speed
	move_and_slide()

var inArea = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") :
		playerIsInArea = true

func apply_knockback(damage_source_pos : Vector2, knockbackP):
	var knockbackDir = damage_source_pos.direction_to(self.global_position) 
	var kn = knockbackDir * knockbackP
	return kn
	
func _on_area_2d_body_exited(body):
	if body.is_in_group("Player") :
		playerIsInArea = false

func _on_timer_timeout():
	damageBar.max_value = MAXHEALT 
	damageBar.value = healt	

func _on_hurt_box_area_exited(area):
	inArea = false

func poison():
	isPoisoned = true
	$Poison.visible = true
	await get_tree().create_timer(.3).timeout
	var i = 0
	while (i<poisonDot):
		i+=1
		_on_hurt_box_2_hurt(MAXHEALT/16, false, false, false, Vector2.ZERO, 0, true, false)
		await get_tree().create_timer(1).timeout
	$Poison.visible = false
	poisonDot = 3
	isPoisoned = false

func _on_hurt_box_2_hurt(damage, canCrit, isMagic, isToxic, angle, knockbackP, isPoison, freeze):
	unfreeze()
	hpBar.visible = true #Rendi la barra degli Hp visibile solo dopo che il mob ha preso danno
	damageBar.visible = true
	$Bar.visible = true
	var crit = false
	damage *= randf_range(1, 1.2)
	var critN = randi_range(1, 100)
	if isToxic:
		if isPoisoned:
			poisonDot+=1
		else :
			poison()
	if not isPoison :
		knockback = apply_knockback(target.global_position, knockbackP)
	if canCrit and critN < PlayerStats.crit:
			crit = true
			damage = damage + damage * (PlayerStats.critDmg)
			healt-=damage
	else :
		healt-=damage
	if freeze: 
		$Freeze.play("Freeze")
		speed = 0
		$Sprite.stop()
		freezed = true
		$UnFreeze.start()
	else :
		$Blink.play("Blink")
		
	DamageNumber.dispay_number(damage, origin.global_position, crit, isMagic, isPoison)
	hpBar.value = healt #Aggiorna barra HP
	# $HPBar/Timer.start()
	$Hit.play()
	if healt <= .2 :
		PlayerStats.exp += 1
		PlayerStats.souls+=1
		queue_free() 
		var enemyDeathEffect = EnemyDeathEffect.instantiate() 
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
	
func choose(array):
	array.shuffle()
	return array.front()

func _on_moving_timer_timeout():
	movingDir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2(1,1), Vector2(-1,-1), Vector2(-1,1), Vector2(1,-1)])
	$MovingTimer/StopMoving.wait_time = randi_range(1,3)
	$MovingTimer/StopMoving.start()

func _on_stop_moving_timeout():
	$MovingTimer.wait_time = randi_range(5,10)
	movingDir = Vector2.ZERO
	$MovingTimer.start()

func unfreeze():
	$Freeze.play("Unfreeze")
	speed = maxSpeed
	$Sprite.play("Move")
	freezed = false

func _on_un_freeze_timeout():
	unfreeze()

func _on_chase_timer_timeout():
	if playerIsInArea:
		$RayCast2D.target_position = to_local(target.global_position)
