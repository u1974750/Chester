extends TileMap


func _on_Sprite_checkPosition():
	var pos = Global.get_pos()
	var center_pos = map_to_world(pos)
	print(center_pos)
	if get_cellv(world_to_map(center_pos)) == -1:
		print("NULOOO")
	else:
		print("ficha")
