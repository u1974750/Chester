extends Node2D

var _canLeft = true
var _canRight = true
var _canTop = true
var _canBot = true

signal enemyTurn

func _ready():
	$AreaBot/HoverEffect.visible = false
	$AreaTop/HoverEffect.visible = false
	$AreaLeft/HoverEffect.visible = false
	$AreaRight/HoverEffect.visible = false

func _input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index == BUTTON_LEFT and event.pressed and Global.turn == 0:
		var previousPos = position
		Global.turn = 1
		if $AreaTop/HoverEffect.visible:
			position.x += 32
			position.y -= 16
		elif $AreaBot/HoverEffect.visible:
			position.x -= 32
			position.y += 16
		elif $AreaLeft/HoverEffect.visible:
			position.x -= 32
			position.y -= 16
		elif $AreaRight/HoverEffect.visible:
			position.x += 32
			position.y += 16
		else:
			Global.turn = 0
			
		if Global.turn == 1: emit_signal("enemyTurn")

	
	
func getPos():
	return position
	
func _on_Area2D_area_entered(area):
	if area.name == "AreaTop": _canTop = true
	elif area.name == "AreaBot": _canBot = true
	elif area.name == "AreaLeft": _canLeft = true
	elif area.name == "AreaRight": _canRight = true
	

func _on_Area2D_area_exited(area):
	if area.name == "AreaTop": _canTop = false
	elif area.name == "AreaBot": _canBot = false
	elif area.name == "AreaLeft": _canLeft = false
	elif area.name == "AreaRight": _canRight = false


	
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


func _on_AreaTop_mouse_exited():
	$AreaTop/HoverEffect.visible = false
func _on_AreaBot_mouse_exited():
	$AreaBot/HoverEffect.visible = false
func _on_AreaLeft_mouse_exited():
	$AreaLeft/HoverEffect.visible = false
func _on_AreaRight_mouse_exited():
	$AreaRight/HoverEffect.visible = false


func _on_Slime_playerTurn():
	Global.turn = 0
