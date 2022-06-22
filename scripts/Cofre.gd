extends Node2D

var changeScene = false

#colisio de la rata al entrar amb el cofre
func _on_Area2D_area_entered(area):	
	if area.name == "AreaTop" or area.name == "AreaBot" or area.name == "AreaLeft" or area.name == "AreaRight":
		_play()

#metode que activa la colisio
func _play():
	$AnimatedSprite.play("open")
	changeScene = true

#gestiona el final de l'animacio per tal de carregar l'escena
func _on_AnimatedSprite_animation_finished():
	if changeScene and Global.actualLevel == 1:
		Global.actualLevel += 1
		get_tree().change_scene("res://escenes/Level1.tscn")
	elif changeScene and Global.actualLevel == 2:
		Global.actualLevel += 1
		get_tree().change_scene("res://escenes/Level2.tscn")
	elif changeScene and Global.actualLevel == 3:
		$victory/ColorRect.visible = true
		Global.actualLevel = 1
		
