extends Node2D




func _on_Area2D_area_entered(area):
	if area.name == "AreaTop" or area.name == "AreaBot" or area.name == "AreaLeft" or area.name == "AreaRight":
		$AnimatedSprite.play("open")
