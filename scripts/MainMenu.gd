extends Control

func _on_Play_button_down():
	$walls/Cofre._play()

func _on_Exit_button_down():
	get_tree().quit()
