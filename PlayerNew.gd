extends CharacterBody2D
class_name Player

#Variabili globali
const ACCELERATION = 400
var MAXSPEED = PlayerStats.ms
const FRICTION = 400
var speed = MAXSPEED
var canMove = true
var DELTA

var canRegenMana = true

enum { #Variabili
	MOVE, #Valore -> 0
	ROLL, #Valore -> 1
	ATTACK, #Valore -> 2
	DEATH, #Valore -> 3
	JUMP
}

var state = MOVE
var stats = PlayerStats
var rollVector = Vector2.DOWN

signal healtChange
signal staminaChange
signal manaChange
signal lvlUp

@export var spellInventory: SpellInventory
@onready var swordHitBox = $DestroyOnDeath/HitBoxPivot/hitBox
@onready var animationPlayer = $DestroyOnDeath/AnimationPlayer
@onready var animationTree = $DestroyOnDeath/AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var staminaBar = $DestroyOnDeath/StaBar
@onready var blink = $Blink
@onready var inventoryUi = $inventoryUi
@onready var invisibleAnim = $"DestroyOnDeath/Invisibilità/Invisible"

@export var gun : Gun
@export var freezingDart : PackedScene
@export var holyArrow : PackedScene


func _ready():
	spellInventory.use_spell.connect(use_spell)
	$Spell/Berserk/AnimationPlayer.play("noFuoco")
	$Spell/Shield/AnimatedSprite2D.visible = false
	$Spell/Shield/Mirroring/CollisionShape2D.disabled = true
	$Spell/Explosions/LamentoDeiMorti/hitBox/CollisionShape2D.disabled = true
	$DestroyOnDeath/HitBoxPivot/hitBox/CollisionShape2D.disabled = true
	animationTree.active = true
	$Spell/Berserk/GPUParticles2D.emitting = false
	Global.set_player_reference(self)
	Global.player = self

func _process(delta):
	$DestroyOnDeath/HitBoxPivot/hitBox.damage = PlayerStats.ad
	MAXSPEED = PlayerStats.ms
	if canRegenMana and PlayerStats.mana < PlayerStats.maxMana:
		regenMana(delta)
	#print("FPS: " + str(Engine.get_frames_per_second()))
	$Gun.rotation = global_position.direction_to(get_global_mouse_position()).angle()
	if canMove and !Global.death:
		DELTA = delta
		match state: #simile a switch (state)
			MOVE: 
				move(delta)
			ROLL:
				roll()
			ATTACK:
				attack()
			DEATH:
				# death()
				pass
			JUMP:
				pass
			
		'''
		if stats.stamina < 25 :
			speed = MAXSPEED / 2 * Global.speedMult
		else :
			speed = MAXSPEED * Global.speedMult
		'''	

func attack():
	# velocity = Vector2.ZERO
	animationState.travel("Attack")
	$DestroyOnDeath/HitBoxPivot/hitBox/CollisionShape2D.disabled = false
	
func attackFinished():
	state = MOVE
	velocity = velocity / 2
	$DestroyOnDeath/HitBoxPivot/hitBox/CollisionShape2D.disabled = true
	

func move(delta) :
	if canMove :
		if Input.is_action_just_pressed("roll") and Global.canRoll:
			state = ROLL
		var inputVector = Vector2.ZERO
		inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		inputVector = inputVector.normalized() #Vettore normalizzato così che il pg non sia più veloce in diagonale
		
		if inputVector != Vector2.ZERO and Global.canMove:
			rollVector = inputVector
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

func rollFinished():
	$HurtBox/CollisionShape2D.disabled = false
	$TrapHurtBox/CollisionShape2D.disabled = false
	state = MOVE

func roll():
	velocity = rollVector * speed * 1.5
	animationState.travel("Roll")
	$HurtBox/CollisionShape2D.disabled = true
	$TrapHurtBox/CollisionShape2D.disabled = true
	move_and_slide()
	# stats.stamina -= 1
	# emit_signal("staminaChange")

func _casting(manaCost):
	Global.casting = true
	stats.mana -= manaCost
	canRegenMana = false
	await get_tree().create_timer(1).timeout
	canRegenMana = true
	
func regenMana(delta):
	PlayerStats.mana += PlayerStats.manaRegen * delta
	emit_signal("manaChange")
	
func healing():
	emit_signal("healtChange")
	
func lvlCheck():
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

func _on_hurt_box_hurt(damage, canCrit, isMagic, isToxic, angle, knockback, isPoison, freeze):
	PlayerStats.healt -= damage / PlayerStats.res
	blink.play("Start")
	emit_signal("healtChange")
	$HitEffect.play()
	Global.shakeStr = 1
	Global.shake = true
	$ShakeTimer.start()

func _on_shake_timer_timeout():
	Global.shake = false
	
func use_spell(spell):
	spell.use(self)
	
func healingSpell(amount, mana):
	if PlayerStats.mana >= mana and PlayerStats.healt < PlayerStats.maxHealt:
		_casting(30)
		$Spell/Heal/GPUParticles2D.emitting = true
		$Spell/Heal/AudioStreamPlayer2D.play()
		if (PlayerStats.healt + amount > PlayerStats.maxHealt):
			PlayerStats.healt = PlayerStats.maxHealt
		else :
			PlayerStats.healt += amount
		healing()

func soulsExplosion(mana):
	if PlayerStats.mana >= mana:
		_casting(mana)
		$Spell/Explosions/LamentoDeiMorti/hitBox.damage = 30 + PlayerStats.souls * .2
		$Spell/Explosions/LamentoDeiMorti/GPUParticles2D.amount = int(PlayerStats.souls / 2) + 10
		Global.shakeStr = 8
		Global.shake = true
		$Spell/Explosions/LamentoDeiMorti/hitBox/CollisionShape2D.disabled = false
		$Spell/Explosions/LamentoDeiMorti/AudioStreamPlayer2D.play()
		$Spell/Explosions/LamentoDeiMorti/GPUParticles2D.emitting = true
		await get_tree().create_timer(0.3).timeout
		Global.shake = false
		$Spell/Explosions/LamentoDeiMorti/hitBox/CollisionShape2D.disabled = true
		PlayerStats.souls = 0
		
func shildSpell(mana):
	if PlayerStats.mana >= 40:
		_casting(mana)
		$Spell/Shield/ShieldTimer.start()
		$Spell/Shield/AnimatedSprite2D.play_backwards("break")
		$Spell/Shield/AnimatedSprite2D.visible = true
		PlayerStats.res += 1
		await $Spell/Shield/AnimatedSprite2D.animation_finished
		$Spell/Shield/AnimatedSprite2D.play("default")
		$Spell/Shield/Mirroring/CollisionShape2D.disabled = false

func _on_shield_timer_timeout():
	PlayerStats.res -= 1
	$Spell/Shield/AnimatedSprite2D.play("break")
	$Spell/Shield/Mirroring/CollisionShape2D.disabled = true
	await $Spell/Shield/AnimatedSprite2D.animation_finished
	$Spell/Shield/AnimatedSprite2D.visible = false
	
var playerCrit
func berskerk(mana):
	if PlayerStats.mana >= mana and PlayerStats.healt - 30 > 1:
		_casting(mana)
		$Spell/Berserk/AnimationPlayer.play("fuoco")
		$Spell/Berserk/GPUParticles2D.emitting = true
		$Spell/Berserk/Berserk.start()
		playerCrit = PlayerStats.crit
		PlayerStats.crit += 50
		PlayerStats.healt -= 30
		healing()
		PlayerStats.ms += 10
		PlayerStats.critMult += .5
		PlayerStats.armor *= 1.2

func _on_berserk_timeout():
	$Spell/Berserk/AnimationPlayer.play("noFuoco")
	PlayerStats.crit = playerCrit
	$Spell/Berserk/GPUParticles2D.emitting = false
	PlayerStats.ms -= 10
	PlayerStats.critMult -= .5
	PlayerStats.armor /= 1.2

func iceSpear(mana):
	gun.bullet = freezingDart
	if PlayerStats.mana >= mana:
		_casting(mana)
		gun.shoot()
		
func holyDart(mana):
	gun.bullet = holyArrow
	if PlayerStats.mana >= mana:
		_casting(mana)
		gun.shoot()

func walkBot():
	$DestroyOnDeath/Sprite2D.play("Walk_Bot")
