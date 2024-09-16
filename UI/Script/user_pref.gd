class_name UserPref extends Resource

@export_range(0, 1, .05) var music_audio_level: float = 1.0
@export_range(0, 1, .05) var sound_audio_level: float = 1.0
@export var action_events: Dictionary = {}

func save() -> void:
	ResourceSaver.save(self, "user://user_prefs.tres")
	
static func load_and_create() -> UserPref:
	var res: UserPref = load("user://user_prefs.tres") as UserPref
	if !res:
		res = UserPref.new()
	return res
