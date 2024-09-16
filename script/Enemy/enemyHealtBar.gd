extends ProgressBar

@export var enemy: CharacterBody2D
@onready var timer = $Timer
@onready var dmgBar = $DamageBar
@onready var stats = $"../Stats"

var previusHealt

func _ready():
	enemy.healtChange.connect(update)
	value = stats.healt
	max_value = enemy.stats.maxHealt
	dmgBar.value = enemy.stats.healt
	dmgBar.max_value = enemy.stats.maxHealt
	previusHealt = enemy.stats.healt
	update()

func update():
	#value = player.stats.healt * 100 / player.stats.maxHealt
	#dmgBar.value = player.stats.healt * 100 / player.stats.maxHealt
	value = enemy.stats.healt
	if previusHealt > enemy.stats.healt :
		timer.start()
	else :
		dmgBar.value = enemy.stats.healt
		
	previusHealt = enemy.stats.healt
	
func _on_timer_timeout():
	dmgBar.value = enemy.stats.healt
		
