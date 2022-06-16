extends CanvasLayer


func _ready():
	$ColorRect.visible = false
	 
func _on_Menu_button_down():
	get_tree().change_scene("res://escenes/MainMenu.tscn")
