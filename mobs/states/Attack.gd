extends State

@export var hitBox : CollisionShape2D

signal attack

@export var attackPlayer: AnimationPlayer

func enter():
	super.enter()
	owner.isAttacking = true
	owner.chase = true
	owner.speed = 1
	if !owner.freezed:
		attackPlayer.play("Attack")
	
func transition():
	if owner.dir.length() > 30:
		owner.isAttacking = false
		get_parent().change_state("Follow")
		if not owner.freezed:
			owner.speed = owner.maxSpeed
