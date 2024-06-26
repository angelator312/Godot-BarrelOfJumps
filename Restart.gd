extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	#self.visible=false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	self.get_parent().get_parent().get_tree().reload_current_scene()
	pass # Replace with function body.
