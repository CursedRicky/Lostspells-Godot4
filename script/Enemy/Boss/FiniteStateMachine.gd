extends Node2D

var current_state : State
var previus_state : State

func _ready():
	current_state = get_child(0) as State
	previus_state = current_state
	current_state.enter()

func change_state(state):
	if state == previus_state.name:
		return
		
	current_state = find_child(state) as State
	current_state.enter()
	
	previus_state.exit()
	previus_state = current_state
