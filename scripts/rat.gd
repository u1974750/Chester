extends Node2D

var _canLeft = true
var _canRight = true
var _canTop = true
var _canBot = true
var side = 0 # 0 top, 1Bot, 2Left, 3Right

signal enemyTurn

#prepara les 4 arees de moviment com a ocultes
func _ready():
	$AreaBot/HoverEffect.visible = false
	$AreaTop/HoverEffect.visible = false
	$AreaLeft/HoverEffect.visible = false
	$AreaRight/HoverEffect.visible = false
	$AnimatedSprite.play("idle")


#GESTIONA INPUT -> moviment de la rata
func _input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index == BUTTON_LEFT and event.pressed and Global.turn == 0:		
		$sound.play()
		if $AreaTop/HoverEffect.visible: 
			Global.turn = 1
			side = 0
			$AnimatedSprite.play("jump_up")
		elif $AreaBot/HoverEffect.visible:
			Global.turn = 1
			side = 1
			$AnimatedSprite.play("jump_up")
		elif $AreaLeft/HoverEffect.visible:
			Global.turn = 1
			side = 2
			$AnimatedSprite.play("jump_up")
		elif $AreaRight/HoverEffect.visible: 
			Global.turn = 1
			side = 3
			$AnimatedSprite.play("jump_up")

#gestiona el moviment		
func _movPlayer():
	if side == 0:
		position.x += 16
		position.y -= 8
	elif side == 1:
		position.x -= 16
		position.y += 8
	elif side == 2:
		position.x -= 16
		position.y -= 8
	elif side == 3:
		position.x += 16
		position.y += 8
	else:
		Global.turn = 0
			
	$AnimatedSprite.play("jump_down")
	if Global.turn == 1: emit_signal("enemyTurn")
	
#signal colisió amb l'enemic		
func _on_AreaRat_area_entered(area):
	if area.name == "EnemyArea": 
		$AnimatedSprite.play("hit")
		
#signal area de moviment al entrar a la colisió del mapa	
func _on_Area2D_area_entered(area):
	if area.name == "AreaTop": _canTop = true
	elif area.name == "AreaBot": _canBot = true
	elif area.name == "AreaLeft": _canLeft = true
	elif area.name == "AreaRight": _canRight = true
	
#signal area de moviment al sortir a la colisió del mapa	
func _on_Area2D_area_exited(area):
	if area.name == "AreaTop": _canTop = false
	elif area.name == "AreaBot": _canBot = false
	elif area.name == "AreaLeft": _canLeft = false
	elif area.name == "AreaRight": _canRight = false


#grup de signals gestiona el hover del ratolí mostrant les arees de moviment	
func _on_AreaTop_mouse_entered():
	if _canTop and Global.turn == 0:
		$AreaTop/HoverEffect.visible = true
func _on_AreaBot_mouse_entered():
	if _canBot and Global.turn == 0:
		$AreaBot/HoverEffect.visible = true
func _on_AreaLeft_mouse_entered():
	if _canLeft and Global.turn == 0:
		$AreaLeft/HoverEffect.visible = true
func _on_AreaRight_mouse_entered():
	if _canRight and Global.turn == 0:
		$AreaRight/HoverEffect.visible = true


#grup de signals gestiona el hover del ratolí ocultant les arees de moviment	
func _on_AreaTop_mouse_exited():
	$AreaTop/HoverEffect.visible = false
func _on_AreaBot_mouse_exited():
	$AreaBot/HoverEffect.visible = false
func _on_AreaLeft_mouse_exited():
	$AreaLeft/HoverEffect.visible = false
func _on_AreaRight_mouse_exited():
	$AreaRight/HoverEffect.visible = false

#canvi de turn
func _on_Slime_playerTurn():
	Global.turn = 0

#gestiona el final de les animacions
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "hit":
		$AnimatedSprite.play("death")
	elif $AnimatedSprite.animation == "death":
		get_tree().reload_current_scene()
	elif $AnimatedSprite.animation == "jump_up":
		_movPlayer()
	elif $AnimatedSprite.animation == "jump_down":
		$AnimatedSprite.play("idle")
