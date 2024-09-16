extends CanvasModulate

@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INITIAL_HOUR = 12

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2*PI) / MINUTES_PER_DAY

signal time_tick(day, hour, minute)

var time = 0.0

func _ready():
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

func _process(delta):
	time += delta * INGAME_SPEED * INGAME_TO_REAL_MINUTE_DURATION
	var value = (sin(time - PI/2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time() 
	
func _recalculate_time():
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
