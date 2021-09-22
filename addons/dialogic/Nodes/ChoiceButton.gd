extends Button

func _process(delta):
	if has_focus():
		if Input.is_action_pressed(get_meta('input_next')):
			emit_signal("button_down")
		if Input.is_action_just_released(get_meta('input_next')):
			emit_signal("button_up")
			emit_signal("pressed")

func _on_Button_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed() == true and pressed == false:
			set_pressed(true)
			emit_signal("pressed")
