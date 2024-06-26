extends RigidBody2D

var boss=false
var health=1
var multiplier=1
var tween
var lastAttack=0

func isBoss():
	return boss
# Called when the node enters the scene tree for the first time.

func _ready():
	
	pass # Replace with function body.

func startPulse():
	tween = self.create_tween()
	tween.tween_property(self, "modulate", Color.RED, 1)
	tween.tween_property(self, "modulate", Color.WHITE, 1)
	tween.set_loops()

func hited(attackBr,scoreFlag=true):
	if(attackBr>lastAttack):
		health-=1
		#print(multiplier*GlobalVariables.scoreMultiplier*2)
		GlobalVariables.addLuckForBoss(0.003)
		if(scoreFlag):
			GlobalVariables.addScore(multiplier*GlobalVariables.scoreMultiplier*2)
			#GlobalVariables.drawScore()
		forDestroy()
		lastAttack=attackBr

func forDestroy():
	if(health<=0):
		if(boss):
			GlobalVariables.setLevelWon(true)
		self.get_parent().remove_child(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if GlobalVariables.levelWon:
		return
	pass
