extends Camera2D

var randomStrenght = 1.0
var shakeFade = 5.0

var rng = RandomNumberGenerator.new()
var shakeStr = 0.0

var targetDis =  0
var centerPos = position
const MAX_DISTANCE = 48

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.cameraFollow:
		randomStrenght = Global.shakeStr
		var direction = centerPos.direction_to(get_local_mouse_position())
		var targetPos = centerPos + direction * targetDis
		
		targetPos = targetPos.clamp(
			centerPos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
			centerPos + Vector2(MAX_DISTANCE, MAX_DISTANCE)
		)
		
		position = targetPos
		if Global.shake:
			applyShake()
		if shakeStr > 0:
			shakeStr = lerpf(shakeStr,0,shakeFade * delta)
			
			offset = randomOffset()	

func _input(event):
	if event is InputEventMouseMotion:
		targetDis = centerPos.distance_to(get_local_mouse_position()) / 2


func applyShake():
	shakeStr = randomStrenght
	

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStr, shakeStr), rng.randf_range(-shakeStr, shakeStr))
