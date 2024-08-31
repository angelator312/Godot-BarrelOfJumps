extends TextureButton

func _on_pressed():
	GlobalVariables.setLevel(get_tree(),2);
	#get_tree().change_scene_to_file("res://level2.tscn")
	pass # Replace with function body.
