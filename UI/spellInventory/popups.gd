extends Control

func ItemPopup(item, pos):
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	
	if mouse_pos.x <= get_viewport_rect().size.x / 2:
		pass
	
	%ItemPopup.popup()

func HideItemPopup():
	%ItemPopup.hide()
