extends Area2D

@onready var ball: RigidBody2D=$"../Barrel"
@onready var coin=$"../Coin"
@onready var whenWon=$"../LevelWon"
@onready var timer: Timer = $"../Timer"
@onready var player:CharacterBody2D = $"../Player2"
#@onready var text=$"../Score"
@onready var whenGameOver= $"../GameOver"

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
			new_node.position = self.position +Vector2(-100, 60) 
			new_node.linear_velocity = Vector2(0,0)
			new_node.gravity_scale = 1
			self.get_parent().add_child(new_node)
			new_node.startPulse()
			var minus=GlobalVariables.luckForBoss
			if  minus >=0.7: minus =0.67
			timer.wait_time = randf_range(0.7-minus, 1.5-minus)
			
		else:
			randomize()
			#var pusks=[pusk1,pusk2,pusk3,pusk4,pusk5,pusk6]
			#pusks.shuffle()
			#var a=randi_range(2,5)
			var b=randi_range(1,2)
			#var puskM=[]
			#for i in range(0,a):
				#puskM.append(pusks[i])
			#print(puskM)
			#for pusk in puskM:
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
				new_node.position = self.position  
				new_node.linear_velocity = Vector2(0,0)
				new_node.gravity_scale = 1
				self.get_parent().add_child(new_node)
				#new_node.apply_impulse(Vector2(100,0),Vector2(randf_range(10,1000),0))
				if(randf()>0.5):
					new_node.apply_impulse(Vector2(randf_range(600,900),randf_range(-300,-400)))
				else:
					new_node.apply_impulse(Vector2(randf_range(-600,-900),randf_range(-300,-400)))
			var minus=GlobalVariables.luckForBoss
			if  minus >=0.7: minus =0.67
			timer.wait_time = randf_range(0.7-minus, 1.5-minus)
			#drawScore()
