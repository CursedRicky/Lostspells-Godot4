extends TextureProgressBar

@export var player: Player
@onready var timer = $Timer
@export var dmgBar : TextureProgressBar
var previusHealt

func _ready():
	player.healtChange.connect(update)
	value = PlayerStats.healt
	max_value = PlayerStats.maxHealt
	dmgBar.value = PlayerStats.healt
	dmgBar.max_value = PlayerStats.maxHealt
	previusHealt = PlayerStats.healt
	update()

func update():
	#value = player.stats.healt * 100 / player.stats.maxHealt
	#dmgBar.value = player.stats.healt * 100 / player.stats.maxHealt
	max_value = PlayerStats.maxHealt
	dmgBar.max_value = PlayerStats.maxHealt
	value = PlayerStats.healt
	if previusHealt > PlayerStats.healt :
		timer.start()
	else :
		dmgBar.value = PlayerStats.healt
		
	previusHealt = PlayerStats.healt
	
func _on_timer_timeout():
	dmgBar.value = value
	
