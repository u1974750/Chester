extends Node2D
#get_tree().change_scene("res://escenes/Level1.tscn")

var to_level_one = false

func _on_Area2D_area_entered(area):
	if area.name == "AreaTop" or area.name == "AreaBot" or area.name == "AreaLeft" or area.name == "AreaRight":
		$AnimatedSprite.play("open")


func _play():
	$AnimatedSprite.play("open")
	to_level_one = true


