extends KinematicBody2D

export var dir = false #false up i down; true left and right 
export var back = false
export var blocks = 4
export var i = 0

var fromHit = false
var previousPos

signal playerTurn


func _ready():
	$AnimatedSprite.flip_h = back

#moviment de l'enemic
func _mov():
	previousPos = position
	if dir:
		if back:
			position.x += 16
			position.y += 8
		else:
			position.x -= 16
			position.y -= 8
	else:
		if back:
			position.x += 16
			position.y -= 8
		else:
			position.x -= 16 #16
			position.y += 8 #8
	i += 1
	if i == blocks or fromHit: 
		back = not back
		$AnimatedSprite.flip_h = back
		i = 0
	$AnimatedSprite.play("jump_down")
	$sound.play()
	emit_signal("playerTurn")
	

#signal amb el Timer
func _on_Timer_timeout():
	$AnimatedSprite.play("jump_up")
	$Timer.wait_time = 1

#canvi de turn, activa el timer
func _on_Rat_enemyTurn():
	$Timer.start()

#gestiona el final de les animacioins
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump_up":
		_mov()
	elif $AnimatedSprite.animation == "jump_down":
		$AnimatedSprite.play("idle")
	elif $AnimatedSprite.animation == "full_jump":
		_mov()

#gestiona (signal) la colisio amb la rata.
func _on_Area2D_area_entered(area):
	if area.name == "AreaRat":
		$AnimatedSprite.play("full_jump")
