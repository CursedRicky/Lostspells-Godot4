extends Node2D

func _ready():
	generate_room()

func generate_room():
	randomize()
	var id = randi_range(1,7)
	
	if Global.roomToMade > 1:
		var r = load("res://rooms/roomsScene/room_" + str(id) + ".tscn").instantiate()
		r.position = $Room.position
		print(Global.roomToMade)
		Global.roomToMade += -1
		add_child(r)
