extends CharacterBody2D
class_name Slime

const EnemyDeathEffect = preload("res://scenes/Enemy/Death/effectSlime.tscn")

var speed = 40
var knockback= Vector2.ZERO
var playerIsInArea = false
var player
var DELTA

const MAXHEALT = 5
var healt = MAXHEALT

@onready var hurtBox = $HurtBox
@onready var hpBar = $HPBar
@onready var damageBar = $HPBar/DamageBar
@onready var damageTimer = $HPBar/Timer
@onready var dmnOrigin = $DMOrigin
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
	DELTA = delta
	knockback = knockback.move_toward(Vector2.ZERO, delta*200)
	var dir = Vector2.ZERO
	if playerIsInArea and !Global.isInvisible:
		dir = navigation_agent_2d.get_next_path_position() - global_position
		dir = dir.normalized()
		if position > player.position:
			$Sprite2D.flip_h = true
		else : 
			$Sprite2D.flip_h = false
		velocity = (knockback * delta + dir) * speed
		move_and_slide()
	else :
		velocity = velocity / 2 * delta
	if healt <= .2 :
		PlayerStats.exp += randi_range(1,3)
		PlayerStats.souls+=1
		queue_free() #Elimina nodo
		var enemyDeathEffect = EnemyDeathEffect.instantiate() #Inizia animazione morte
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position #Posizione l'effetto nella stessa posizione dello slime
	move_and_slide()

var inArea = false

func _on_hurt_box_area_entered(area): #Il mob è colpito dal giocatore
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
	DamageNumber.dispay_number(damage, dmnOrigin.global_position, crit)
	area.damage = areaD
	hpBar.value = healt #Aggiorna barra HP
	damageTimer.start()
	knockback = area.knockbackVector * 200 #Prendi knockback
	hurtBox.createHitEffect() #Avvia animazione colpo
	$HitSound.play()
	$AnimationPlayer2.play("Blink")

func dpsDamage(area):
	while inArea:
		healt -= area.damage


func _on_area_2d_body_entered(body):
	if body is Player :
		playerIsInArea = true
		player = body


func _on_area_2d_body_exited(body):
	if body is Player :
		velocity = velocity.move_toward(Vector2.ZERO, 400*DELTA)
		playerIsInArea = false


func _on_timer_timeout():
	damageBar.value = healt


func _on_hurt_box_area_exited(area):
	inArea = false


func _on_path_timer_timeout():
	navigation_agent_2d.target_position = target.global_position
