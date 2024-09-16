extends Control

@export var player : Player
@export var hideOnPause : Control

var iter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Crit.disabled = true
	$CanvasLayer/Crit.visible = false
	$CanvasLayer/Armor.disabled = true
	$CanvasLayer/Armor.visible = false
	$CanvasLayer/ArmorLabel.visible = false
	$CanvasLayer/CritLabel.visible = false
	$CanvasLayer/Points.visible = false
	$CanvasLayer/MSLabel.visible = false
	$CanvasLayer/MS.disabled = true
	$CanvasLayer/MS.visible = false
	$CanvasLayer/HealtLabel.visible = false
	$CanvasLayer/Healt.disabled = true
	$CanvasLayer/Healt.visible = false
	$CanvasLayer/ManaRegLabel.visible = false
	$CanvasLayer/ManaReg.disabled = true
	$CanvasLayer/ManaReg.visible = false
	$CanvasLayer/AdLabel.visible = false
	$CanvasLayer/Ad.disabled = true
	$CanvasLayer/Ad.visible = false

func testEsc():
	if Input.is_action_just_pressed("inventory") and !get_tree().paused:
		if iter % 2 == 0:
			openInve()
			hideOnPause.visible = false
		else :
			closeInve()
			hideOnPause.visible = true
		iter+=1
	if Input.is_action_just_pressed("Esci"):
		closeInve()
		iter = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.canPause:
		testEsc()
	$CanvasLayer/CritLabel.text = str(PlayerStats.critLvl)
	$CanvasLayer/ArmorLabel.text = str(PlayerStats.armorLvl)
	$CanvasLayer/Points.text = str(PlayerStats.skillPoint)
	$CanvasLayer/MSLabel.text = str(PlayerStats.msLvl)
	$CanvasLayer/HealtLabel.text = str(PlayerStats.healtLvl)
	$CanvasLayer/ManaRegLabel.text = str(PlayerStats.manaRegenLvl)
	$CanvasLayer/AdLabel.text = str(PlayerStats.adLvl)


func openInve():
	Global.canAttack = false
	$AnimationPlayer.play("blur")
	await $AnimationPlayer.animation_finished
	$CanvasLayer/Crit.disabled = false
	$CanvasLayer/Crit.visible = true
	$CanvasLayer/Armor.disabled = false
	$CanvasLayer/Armor.visible = true
	$CanvasLayer/ArmorLabel.visible = true
	$CanvasLayer/CritLabel.visible = true
	$CanvasLayer/Points.visible = true
	$CanvasLayer/MSLabel.visible = true
	$CanvasLayer/MS.disabled = false
	$CanvasLayer/MS.visible = true
	$CanvasLayer/HealtLabel.visible = true
	$CanvasLayer/Healt.disabled = false
	$CanvasLayer/Healt.visible = true
	$CanvasLayer/ManaRegLabel.visible = true
	$CanvasLayer/ManaReg.disabled = false
	$CanvasLayer/ManaReg.visible = true
	$CanvasLayer/AdLabel.visible = true
	$CanvasLayer/Ad.disabled = false
	$CanvasLayer/Ad.visible = true
	Global.canAttack = false
	Global.canMove = false
	Global.canRoll = false
	Global.cameraFollow = false
	
func closeInve():
	Global.canAttack = true
	$AnimationPlayer.play_backwards("blur")
	$CanvasLayer/Crit.disabled = true
	$CanvasLayer/Crit.visible = false
	$CanvasLayer/Armor.disabled = true
	$CanvasLayer/Armor.visible = false
	$CanvasLayer/ArmorLabel.visible = false
	$CanvasLayer/CritLabel.visible = false
	$CanvasLayer/Points.visible = false
	$CanvasLayer/MSLabel.visible = false
	$CanvasLayer/MS.disabled = true
	$CanvasLayer/MS.visible = false
	$CanvasLayer/HealtLabel.visible = false
	$CanvasLayer/Healt.disabled = true
	$CanvasLayer/Healt.visible = false
	$CanvasLayer/ManaRegLabel.visible = false
	$CanvasLayer/ManaReg.disabled = true
	$CanvasLayer/ManaReg.visible = false
	$CanvasLayer/AdLabel.visible = false
	$CanvasLayer/Ad.disabled = true
	$CanvasLayer/Ad.visible = false
	Global.canAttack = true
	Global.canMove = true
	Global.canRoll = true
	Global.cameraFollow = true


func _on_crit_pressed():
	if PlayerStats.skillPoint > 0 and PlayerStats.critLvl < 10:
		PlayerStats.critLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.crit += 7


func _on_armor_pressed():
	if PlayerStats.skillPoint > 0 and PlayerStats.armorLvl < 10:
		PlayerStats.armorLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.armor += 10


func _on_ms_pressed():
	if PlayerStats.skillPoint > 0 and PlayerStats.msLvl < 10:
		PlayerStats.msLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.ms += 3


func _on_healt_pressed():
	if PlayerStats.skillPoint > 0:
		PlayerStats.healtLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.maxHealt *= 1.1


func _on_mana_reg_pressed():
	if PlayerStats.skillPoint > 0:
		PlayerStats.manaRegenLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.manaRegen += 5


func _on_ad_pressed():
	if PlayerStats.skillPoint > 0:
		PlayerStats.adLvl += 1
		PlayerStats.skillPoint -= 1
		PlayerStats.ad += 2
