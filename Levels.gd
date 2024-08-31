extends TextureButton


func _on_pressed():
	GlobalVariables.setLevel(get_tree(),1);
	#get_tree().change_scene_to_file("res://level1.tscn")
	pass # Replace with function body.
