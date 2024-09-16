extends TextureProgressBar

@export var player: Player
@onready var timer = $Timer
@onready var dmgBar = $DamageBar
var previusMana

func _ready():
	value = PlayerStats.mana
	max_value = PlayerStats.maxMana
	dmgBar.value = PlayerStats.mana
	dmgBar.max_value = PlayerStats.maxMana
	previusMana = PlayerStats.mana
	update()

func _process(delta):
	update()

func update():
	value = PlayerStats.mana
	dmgBar.value = PlayerStats.mana
	previusMana = PlayerStats.mana
	
func _on_timer_timeout():
	dmgBar.value = PlayerStats.mana
	print("Ciao")
		
