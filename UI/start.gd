extends Control

func _on_video_stream_player_finished():
	SceneTransition._scene_transition_no_anim("res://UI/MainUI.tscn")
