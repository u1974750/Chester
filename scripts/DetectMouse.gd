extends TileMap


func _unhandled_input(event : InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	var mousePos = get_viewport().get_mouse_position()
	var tile_pos = map_to_world(world_to_map(mousePos))
	print(tile_pos)
	
	
