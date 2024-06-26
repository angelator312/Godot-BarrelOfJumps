extends TextureButton

#@onready var animations= $"AnimatedButton"

func _on_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.
