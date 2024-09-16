extends ProgressBar

@export var player = Player
var sb = StyleBoxFlat.new()

func _ready():
	player.staminaChange.connect(update)
	update()
	value = player.stats.stamina
	max_value = player.stats.maxStamina

func update():
	value = player.stats.stamina
	if value < 25:
		add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("ff0000")
	elif value > 25 and value <= 50:
		add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("ba9432")
	else :
		add_theme_stylebox_override("fill", sb)
		sb.bg_color = Color("00b936")
