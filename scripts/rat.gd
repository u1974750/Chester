extends Node2D

signal checkPosition

func _ready():
	$AreaBot/HoverEffect.visible = false
	$AreaTop/HoverEffect.visible = false
	$AreaLeft/HoverEffect.visible = false
	$AreaRight/HoverEffect.visible = false

func _input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index == BUTTON_LEFT and event.pressed:
		var previousPos = position
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
			return

		Global.set_pos(position)
		emit_signal("checkPosition")
		
	
func getPos():
	return position
	
	
	
func _on_AreaTop_mouse_entered():
	$AreaTop/HoverEffect.visible = true
func _on_AreaBot_mouse_entered():
	$AreaBot/HoverEffect.visible = true
func _on_AreaLeft_mouse_entered():
	$AreaLeft/HoverEffect.visible = true
func _on_AreaRight_mouse_entered():
	$AreaRight/HoverEffect.visible = true


func _on_AreaTop_mouse_exited():
	$AreaTop/HoverEffect.visible = false
func _on_AreaBot_mouse_exited():
	$AreaBot/HoverEffect.visible = false
func _on_AreaLeft_mouse_exited():
	$AreaLeft/HoverEffect.visible = false
func _on_AreaRight_mouse_exited():
	$AreaRight/HoverEffect.visible = false
