extends TextureButton

@export var player : Player
@onready var label =  $Quantity
@export var healingPart : GPUParticles2D
var color = "#FFF"
var regen = false
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(Global.healtPotion)
	label.label_settings = LabelSettings.new()
	label.label_settings.font = load("res://art/Font/font1.ttf")
	healingPart.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.label_settings.outline_color = color
	$Quantity.text = str(Global.healtPotion)
	if Global.healtPotion > 0 :
		if Input.is_action_just_pressed("q"):
			if PlayerStats.healt != PlayerStats.maxHealt:
				regen = true
				Global.healtPotion -= 1
				$Regen.start()	
	if regen :
		if PlayerStats.healt + 1 > PlayerStats.maxHealt:
			PlayerStats.healt = PlayerStats.maxHealt
		else :
			PlayerStats.healt += 1.5 * delta
		player.healing()
	healingPart.emitting = regen


func _on_regen_timeout():
	regen = false
