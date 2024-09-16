extends CharacterBody2D

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos 

var is_roaming

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$Sprite2D.play("idle")
	elif current_state == 2:
		if dir.x == -1:
			$Sprite2D.play("walk_w")
		if dir.x == 1:
			$Sprite2D.play("walk_e")
		if dir.y == -1:
			$Sprite2D.play("walk_n")
		if dir.y == 1:
			$Sprite2D.play("walk_s")
			
	if is_roaming:
		match current_state:
			IDLE: 
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
				

func choose(array) :
	array.shuffle()
	return array.front()
	
func move(delta):
	position += dir * speed * delta


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
