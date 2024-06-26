extends Area2D

@onready var pusk1 = $"../Pusk"
@onready var pusk2 = $"../Pusk2"
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
			GlobalVariables.openLevel(2)
			GlobalVariables.setLevelWon(true)
			whenWon.visible=true
			GlobalVariables.closeLevel(1)
			
		#if position.direction_to(body.position).x < 0:
			#body.linear_velocity += Vector2.RIGHT * 1000
		#else:
			#body.linear_velocity += Vector2.LEFT * 1000
		self.get_parent().remove_child(body)
		GlobalVariables.updateOnNonBossCollisson(body.multiplier)
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
			var puskM=[]
			var a=randi_range(1,3)
			if(a==1):puskM.append(pusk1)
			if(a==2):puskM.append(pusk2)
			if(a==3):
				puskM.append(pusk2)
				puskM.append(pusk1)
			for pusk in puskM:
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
			var minus=GlobalVariables.luckForBoss
			if  minus >=0.7: minus =0.67
			timer.wait_time = randf_range(0.7-minus, 1.5-minus)
			#drawScore()
