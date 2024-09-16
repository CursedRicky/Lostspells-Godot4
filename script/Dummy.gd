extends StaticBody2D

@onready var origin = $Origin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dpsDamage(area):
	pass

var inArea = false

func _on_hurt_box_area_entered(area):
	$AnimationPlayer.play("attack")
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
			damage = area.damage + area.damage * 0.5 #Danno da critico 150%
		else :
			damage = area.damage #Mob prende danno
	else:
		inArea = true
		dpsDamage(area)
	if Global.isInvisible:
		Global.isInvisible = false
	DamageNumber.dispay_number(damage, origin.global_position, crit)
	area.damage = areaD
	


func _on_hurt_box_area_exited(area):
	inArea = false
