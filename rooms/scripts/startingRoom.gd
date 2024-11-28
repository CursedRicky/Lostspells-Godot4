extends Node2D

func _ready():
	Global.roomToMade = randi_range(Global.min_rooms, Global.max_rooms)
	generate_room()
	
func generate_room():
	randomize()
	var id = randi_range(8, 8)
	
	if Global.roomToMade > 1:
		var r = load("res://rooms/roomsScene/room_" + str(id) + ".tscn").instantiate()
		r.position = $Room.position
		print(Global.roomToMade)
		add_child(r)
		Global.roomToMade -= 1
