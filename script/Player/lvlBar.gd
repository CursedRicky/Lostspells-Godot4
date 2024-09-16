extends TextureProgressBar

@export var player: Player

func _process(delta):
	update()
	value = PlayerStats.exp

func _ready():
	value = PlayerStats.exp
	max_value = PlayerStats.maxExp
	update()

func update():
	$Label.text = str(PlayerStats.lvl)
	max_value = PlayerStats.maxExp
	
