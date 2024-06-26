extends Node2D
@onready var level1= $Level1
@onready var level2= $Level2
@onready var level3= $Level3
@onready var level4= $Level4
@onready var level5= $Level5
func _ready():
	if(GlobalVariables.levelWon):
		GlobalVariables.setLevelWon(false)
		GlobalVariables.addLuckForBoss(0-GlobalVariables.luckForBoss)
	var levels=[level1,level2,level3,level4,level5]
	for i in range(0,levels.size()):
		#print(i)
		if(!GlobalVariables.openLevels[i]):
			levels[i].disabled=true
	


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://level3.tscn")
	pass # Replace with function body.


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://level4.tscn")
	pass # Replace with function body.


func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://level5.tscn")
	pass # Replace with function body.
