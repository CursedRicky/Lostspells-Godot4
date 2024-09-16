extends TextureButton

@onready var CD = $CD
@onready var key = $Key
@onready var time = $Time
@onready var timer = $Timer

@export var keyC : String
@export var ench : String

func _ready():
	key.text = keyC
	CD.max_value = timer.wait_time
	set_process(false)
	
func _process(delta):
	time.text = "%3.0f" % timer.time_left
	CD.value = timer.time_left
	if Input.is_action_just_pressed(ench):
		_enable()

func _on_pressed():
	_enable()

func _on_timer_timeout():
	_disable()
	
func _enable():
	timer.start()
	disabled = true
	set_process(true)
	
func _disable():
	disabled = false
	time.text = ""
	CD.value = 0
	set_process(false)
