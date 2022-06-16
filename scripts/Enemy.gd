extends KinematicBody2D

export var dir = false #false up i down; true left and right 
export var back = false
export var blocks = 4
export var i = 0

var animDown = false
var fromHit = false

signal playerTurn


func _ready():
	$AnimatedSprite.flip_h = back

func _mov():
	if dir:
		if back:
			position.x += 32
			position.y += 16
		else:
			position.x -= 32
			position.y -= 16
	else:
		if back:
			position.x += 32
			position.y -= 16
		else:
			position.x -= 32 #16
			position.y += 16 #8
	i += 1
	if i == blocks or fromHit: 
		back = not back
		$AnimatedSprite.flip_h = back
		i = 0
	animDown = false
	$AnimatedSprite.play("jump_down")
	emit_signal("playerTurn")
	

func _on_Timer_timeout():
	$AnimatedSprite.play("jump_up")
	$Timer.wait_time = 1

func _on_Rat_enemyTurn():
	$Timer.start()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump_up":
		_mov()
	elif $AnimatedSprite.animation == "jump_down":
		animDown = true
		$AnimatedSprite.play("idle")


func _on_Area2D_area_entered(area):
	print("collision")
	if area.name == "AreaRat":
		print("COLLISION")
		back = not back
		fromHit = true
		_mov()
