extends Area2D

@onready var pusk1 = $"../Pusk"
@onready var pusk2 = $"../Pusk2"
@onready var pusk3 = $"../Pusk3"
@onready var pusk4 = $"../Pusk4"
@onready var pusk5 = $"../Pusk5"
@onready var pusk6 = $"../Pusk6"
#var score=0
@onready var ball: RigidBody2D=$"../Barrel2"
@onready var coin=$"../Coin2"
@onready var whenWon=$"../LevelWon"
@onready var timer: Timer = $"../Timer"
@onready var player:CharacterBody2D = $"../Player2"
#@onready var text=$"../Score"
@onready var whenGameOver= $"../GameOver"
var deltaTime=0


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.updateDeltaTime()
	#drawScore()
	#GlobalVariables.addLuckForBoss(0-GlobalVariables.luckForBoss)
	#print(timer.paused)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#func drawScore():
	##print(text)
	#text.text="	"+str(GlobalVariables.score) + "G"

func _on_body_entered(body):
	if body is RigidBody2D:
		if(body.has_method("isBoss") && body.isBoss()):
			GlobalVariables.openLevel(4)
			whenWon.visible=true
			GlobalVariables.setLevelWon(true)
			GlobalVariables.closeLevel(3)
			
		#if position.direction_to(body.position).x < 0:
			#body.linear_velocity += Vector2.RIGHT * 1000
		#else:
			#body.linear_velocity += Vector2.LEFT * 1000
		self.get_parent().remove_child(body)
		#GlobalVariables.updateOnNonBossCollisson(body.multiplier)
		#drawScore()
		#if body is CharacterBody2D:
		#body.linear_velocity += Vector2.RIGHT * 1000
	if body is CharacterBody2D:
		body.gameOver=true
		whenGameOver.visible=true

func _on_timer_timeout():
		if GlobalVariables.levelWon:
			
			return
		#print(ball)
		if(player.gameOver):return
		var new_node:RigidBody2D
		
		if(GlobalVariables.boss):
			GlobalVariables.setBoss(false)
			new_node = ball.duplicate()
			new_node.boss=true
			new_node.health=3
			new_node.multiplier=10
			for c in new_node.get_children():
				c.scale = c.scale * Vector2(2.5,2.5)
			new_node.visible = true
			new_node.position = pusk1.position +Vector2(-100, 60) 
			new_node.linear_velocity = Vector2(0,0)
			new_node.gravity_scale = 1
			self.get_parent().add_child(new_node)
			new_node.startPulse()
			var minus=GlobalVariables.luckForBoss
			if  minus >=0.7: minus =0.67
			timer.wait_time = randf_range(0.7-minus, 1.5-minus)
			
		else:
			randomize()
			var pusks=[pusk1,pusk2,pusk3,pusk4,pusk5,pusk6]
			pusks.shuffle()
			var a=randi_range(2,5)
			var b=randi_range(1,2)
			var puskM=[]
			for i in range(0,a):
				puskM.append(pusks[i])
			#print(puskM)
			for pusk in puskM:
				for i in b:
					if(randf()>=0.6+GlobalVariables.notLuckForCoins):
						new_node = coin.duplicate()
					else:
						new_node = ball.duplicate()
						if(randf() >= .9 - GlobalVariables.luckForBoss):
							new_node.multiplier=2
							for c in new_node.get_children():
								c.scale = c.scale * Vector2(2,2)
					new_node.visible = true
					#new_node.position = pusk.position +Vector2(-100, 60) 
					new_node.position = pusk.position  
					new_node.linear_velocity = Vector2(0,0)
					new_node.gravity_scale = 1
					self.get_parent().add_child(new_node)
					#new_node.apply_impulse(Vector2(100,0),Vector2(randf_range(10,1000),0))
					if(pusk.position.x==-152):
						new_node.apply_impulse(Vector2(randf_range(600,900),randf_range(-700,-800)))
					else:
						new_node.apply_impulse(Vector2(randf_range(-600,-900),randf_range(-700,-800)))
			var minus=GlobalVariables.luckForBoss
			if  minus >=0.7: minus =0.67
			timer.wait_time = randf_range(0.7-minus, 1.5-minus)
			#drawScore()
