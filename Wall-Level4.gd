extends StaticBody2D

var posoka=1

func _physics_process(_delta):
	self.position.y+=randf()*posoka
	if(self.position.y>579):posoka=-1
	if(self.position.y<70):posoka=1
	#print(self.position.y)
