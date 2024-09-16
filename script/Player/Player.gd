extends CharacterBody2D

#Variabili globali
const ACCELERATION = 400
var MAXSPEED = PlayerStats.ms
const FRICTION = 400
var staminaRegeneration = 5
var speed = MAXSPEED
var canMoveE = true
var canMove = true
var DELTA
var canRegenMana = true
var canTakeDamage = true

@onready var swordHitBox = $DestroyOnDeath/HitBoxPivot/SwordHitBox
@onready var animationPlayer = $DestroyOnDeath/AnimationPlayer
@onready var animationTree = $DestroyOnDeath/AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var hurtBox = $DestroyOnDeath/HurtBox
@onready var staminaBar = $DestroyOnDeath/StaBar
@onready var blink = $Blink
@onready var inventoryUi = $inventoryUi
@onready var invisibleAnim = $"DestroyOnDeath/Invisibilità/Invisible"

enum { #Variabili
	MOVE, #Valore -> 0
	ROLL, #Valore -> 1
	ATTACK, #Valore -> 2
	DEATH #Valore -> 3
}

var state = MOVE
var stats = PlayerStats
var rollVector = Vector2.DOWN

signal healtChange
signal staminaChange
signal manaChange
signal lvlUp

func _ready():
	$DestroyOnDeath/HitBoxPivot/hitBox/CollisionShape2D.disabled = true
	animationTree.active = true
	swordHitBox.knockbackVector = rollVector
	Global.set_player_reference(self)
	Global.player = self

func _process(delta):
	MAXSPEED = PlayerStats.ms
	#print("FPS: " + str(Engine.get_frames_per_second()))
	$DestroyOnDeath/Gun.rotation = global_position.direction_to(get_global_mouse_position()).angle()
	if canMove and !Global.death:
		lvlUpC()
		DELTA = delta
		match state: #simile a switch (state)
			MOVE: 
				move(delta)
			ROLL:
				roll()
			ATTACK:
				attack()
			DEATH:
				death()
				
		if PlayerStats.healt <= 0 :
			state = DEATH
		
		if PlayerStats.stamina >= 100:
			staminaBar.visible = false
		else : 
			staminaBar.visible = true
			if stats.canRegenerateStamina and canMoveE and canMove:
				stats.stamina += staminaRegeneration * delta
				emit_signal("staminaChange")
				
		if canRegenMana and stats.mana < stats.maxMana:
			stats.mana += PlayerStats.manaRegen * delta
			emit_signal("manaChange")
				
		if stats.stamina < 25 :
			speed = MAXSPEED / 2 * Global.speedMult
		else :
			speed = MAXSPEED * Global.speedMult
		
	elif !Global.death:
		animationPlayer.stop()
#'''

func move(delta) :
	if (canMoveE and canMove) :
		var inputVector = Vector2.ZERO
		inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		inputVector = inputVector.normalized() #Vettore normalizzato così che il pg non sia più veloce in diagonale
		
		if inputVector != Vector2.ZERO:
			rollVector = inputVector
			swordHitBox.knockbackVector = inputVector
			animationTree.set("parameters/Idle/blend_position", inputVector)
			animationTree.set("parameters/Run/blend_position", inputVector)
			animationTree.set("parameters/Attack/blend_position", inputVector)
			animationTree.set("parameters/Roll/blend_position", inputVector)
			animationState.travel("Run") #Cambia animazione quando cammini
			velocity = velocity.move_toward(inputVector * speed, ACCELERATION * delta)
		else :
			animationState.travel("Idle") #Cambia animazione quando stai fermo
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		move_and_slide()
		
		if Input.is_action_just_pressed("attack") :
			if Global.canAttack:
				state = ATTACK
		
		if Input.is_action_just_pressed("roll") and (stats.stamina - 25) > 10:
			state = ROLL

func lvlUpC():
	if PlayerStats.exp == PlayerStats.maxExp:
		PlayerStats.lvl += 1
		PlayerStats.exp = 1
		PlayerStats.maxExp *= 1.3
		PlayerStats.skillPoint += 1
	elif PlayerStats.exp > PlayerStats.maxExp:
		var temp =  PlayerStats.exp - PlayerStats.maxExp
		PlayerStats.lvl += 1
		PlayerStats.exp = temp + 1
		PlayerStats.maxExp *= 1.3
		PlayerStats.skillPoint += 1
	emit_signal("lvlUp")

func roll():
	velocity = rollVector * speed * 1.5
	animationState.travel("Roll")
	move_and_slide()
	stats.stamina -= 1
	emit_signal("staminaChange")

func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attackFinished():
	state = MOVE
	velocity = velocity / 2
	Global.isInvisible = false
	
func rollFinished():
	state = MOVE
	
func death():
	Global.death = true
	SceneTransition._scene_transition("res://scenes/Player/Death.tscn")

func _on_hurt_box_area_entered(area): #Il giocatore prende danno
	if canTakeDamage:
		PlayerStats.healt -= area.damage / PlayerStats.res
		emit_signal("healtChange")
		Global.isInvisible = false
		$HitEffect.play()
	
func healing():
	emit_signal("healtChange")
	
func _casting(manaCost):
	stats.mana -= manaCost
	canRegenMana = false
	emit_signal("manaChange")
	await get_tree().create_timer(1).timeout
	canRegenMana = true

func _on_hurt_box_invincibility_started():
	blink.play("Start")


func _on_hurt_box_invincibility_ended():
	blink.play("Stop")

	
