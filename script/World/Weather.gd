extends Node2D

var currentWeather = "rain"

func _ready():
	update()
	if currentWeather == "rain":
		$AnimationPlayer.play("toRain")

func _on_timer_timeout():
	if Global.canRain:
		if currentWeather == "none":
			currentWeather = "rain"
			Global.weather = currentWeather
			$AnimationPlayer.play("toRain")
			#$Timer.wait_time = randf_range(180,300)
			#$Timer.wait_time = randf_range(60,80)
			$Timer.start()
		elif currentWeather == "rain":
			currentWeather = "none"
			Global.weather = currentWeather
			#$Timer.wait_time = randf_range(60,80)
			$AudioStreamPlayer2D.stop()
			#$Timer.wait_time = randf_range(480,600)
			$Timer.start()

func _process(delta):
	if !Global.canRain:
		currentWeather = "none"
		$AudioStreamPlayer2D.stop()
	Global.weather = currentWeather
	update()
		
		
func update() :
	
	if currentWeather == "none":
		$rain.visible = false
		$snow.visible = false
		$rainColor.visible = false
	elif currentWeather == "rain":
		$rain.visible = true
		$snow.visible = false
		#$rainColor.visible = true
	elif currentWeather == "snow":
		$rain.visible = false
		$snow.visible = true
		$rainColor.visible = false

func sound():
	$AudioStreamPlayer2D.play()
