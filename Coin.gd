extends RigidBody2D

func addScore():return 3;
var multiplier=3
# Called when the node enters the scene tree for the first time.
func _ready():
	#self.
	pass # Replace with function body.

#func hited(_attackBr):
	#GlobalVariables.addScore(multiplier*GlobalVariables.scoreMultiplier*2)
	#self.get_parent().remove_child(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalVariables.levelWon:
		return
	pass
	
