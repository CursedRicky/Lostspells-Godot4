extends Node2D

func _ready():
	generate_room()

func generate_room():
	randomize()
	var id = randi_range(1,7)
	var idL = randi_range(1,1)
	
	if Global.roomToMade > 1:
		var r = load("res://rooms/roomsScene/room_" + str(id) + ".tscn").instantiate()
		r.position = $Room.position
		Global.roomToMade += -1
		add_child(r)
		
	var l = load("res://rooms/roomsScene/left/room_" + str(idL) + ".tscn").instantiate()
	l.position = $RoomLeft.position
	add_child(l)
