extends Node2D

@onready var score=$Score
@onready var jumpMore=$HBoxContainer/JumpMore
@onready var moreHealth=$HBoxContainer/MoreHealth
@onready var moreMultiplier=$HBoxContainer/MoneyMultiplier
@onready var lessTime=$HBoxContainer/LessTimeForSword

func _ready():
	score.text="	"+str(GlobalVariables.score) + "G"
	
	jumpMore.text="Max jumps + 1 \n"+str(GlobalVariables.prices[0]*100) + "G"
	if(GlobalVariables.score<GlobalVariables.prices[0]*100):
		jumpMore.disabled=true
	
	moreHealth.text="More lives + 1 \n"+str(GlobalVariables.prices[1]*100) + "G"
	if(GlobalVariables.score<GlobalVariables.prices[1]*100):
		moreHealth.disabled=true
	
	moreMultiplier.text="More Gold Multiplier \n"+str(GlobalVariables.prices[2]*100) + "G"
	if(GlobalVariables.score<GlobalVariables.prices[2]*100):
		moreMultiplier.disabled=true
	
	lessTime.text="Less cooldown for sword \n"+str(GlobalVariables.prices[3]*100) + "G"
	if(GlobalVariables.score<GlobalVariables.prices[3]*100):
		lessTime.disabled=true
	
func _on_jump_more_pressed():
	if(GlobalVariables.score>=GlobalVariables.prices[0]*100):
		PlayerVariables.maxJumps+=1
		GlobalVariables.updatePrices(0)
		self.get_tree().reload_current_scene()
	else:
		#tooExpensive.visible=true
		pass # Replace with function body.


func _on_more_health_pressed():
	if(GlobalVariables.score>=GlobalVariables.prices[1]*100):
		PlayerVariables.startLives+=1
		GlobalVariables.updatePrices(1)
		self.get_tree().reload_current_scene()
	
	pass # Replace with function body.


func _on_money_multiplier_pressed():
	if(GlobalVariables.score>=GlobalVariables.prices[2]*100):
		GlobalVariables.addMultiplier(5)
		GlobalVariables.updatePrices(2)
		self.get_tree().reload_current_scene()
	
	pass # Replace with function body.


func _on_less_time_for_sword_pressed():
	if(GlobalVariables.score>=GlobalVariables.prices[3]*100):
		PlayerVariables.defaultTimeToSword-=0.5
		GlobalVariables.updatePrices(3)
		self.get_tree().reload_current_scene()

	pass # Replace with function body.
