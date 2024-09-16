extends PointLight2D

var inArea = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and inArea:
		PlayerStats.souls += 10
		randStat()
		randStat()
		queue_free()


func _on_area_2d_area_entered(area):
	inArea = true


func _on_area_2d_area_exited(area):
	inArea = false

func randStat():
	var rand = randi_range(0,3)
	match rand:
		0:
			PlayerStats.crit += 15
		1:
			PlayerStats.armor += 5
		2:
			PlayerStats.maxHealt += 25
		3: 
			PlayerStats.ms += 10
