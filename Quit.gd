extends Button



func _on_pressed():
	GlobalVariables.save_game()
	get_tree().quit() # default behavior
	pass # Replace with function body.
