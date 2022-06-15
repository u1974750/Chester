extends Area2D

export var dir = false #false up i down; true left and right 
export var back = false
export var blocks = 4

signal playerTurn

var i = 0

func _ready():
	$AnimatedSprite.flip_h = back

func _mov():
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
			position.x -= 16
			position.y += 8
	i += 1
	if i == blocks: 
		back = not back
		$AnimatedSprite.flip_h = back
		i = 0
	emit_signal("playerTurn")
	

func _on_Timer_timeout():
	_mov()
	$Timer.wait_time = 1




func _on_Rat_enemyTurn():
	$Timer.start()
