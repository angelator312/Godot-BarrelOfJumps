extends Node

var notLuckForCoins=0.001
var luckForBoss=0
var luck=0
#var luckForBoss=0.5
#var score=30000
var score=0
#@onready var text=$"../Text"
var scoreMultiplier=100

# more jumps, lives, multiplier; less timeForSword
var pricesPlus=[30,90,130,120]

# more jumps, lives, multiplier; less timeForSword

var prices=[50,100,140,130]


#func drawScore():
	#print(text)
	##text.text="	"+str(score) + "G"


func addMultiplier(amount):
	scoreMultiplier+=amount

func updatePrices(ind):
	score-=prices[ind]*100
	prices[ind]+=pricesPlus[ind]

#var openLevels=[true,true,false,false,false]
var openLevels=[true,false,false,false,false]
var levelWon=false
var boss = false
#var bosses=0

func _ready():
	load_game()

func addScore(amount):
	score+=amount

func updateDeltaTime():
	notLuckForCoins=(score/1000-luck)/210
	#self.deltaTime=(score/100)/10-luck/10
	if(notLuckForCoins>=4):
		notLuckForCoins=3.999
		
	if(luckForBoss>=.60 ):
		boss=true
		#bosses+=1
		#print(boss)

func  updateOnNonBossCollisson(multiplier):
		luckForBoss+=0.003
		score+=scoreMultiplier * multiplier
		updateDeltaTime()
		
func addLuckForBoss(amount):
	luckForBoss+=amount

func openLevel(level):
	openLevels[level]=true
	

func closeLevel(level):
	openLevels[level]=false
	
func setBoss(state):
	boss=state
	
func  setLevelWon(flag):
	levelWon=flag
	self.save_game()


func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify({
		"notLuckForCoins": notLuckForCoins,
		"luckForBoss": luckForBoss,
		"luck": luck,
		"score": score,
		"scoreMultiplier": scoreMultiplier,
	})
	# Store the save dictionary as a new line in the save file.
	save_game.store_line(json_string)

func load_game():
	if !FileAccess.file_exists("user://savegame.save"):
		return 
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var line = save_game.get_line()
	var saved_data : Dictionary = JSON.parse_string(line)
	notLuckForCoins = saved_data.get("notLuckForCoins", 0)
	luckForBoss = saved_data.get("luckForBoss", 0)
	luck = saved_data.get("luck", 0)
	score = saved_data.get("score", 0)
	scoreMultiplier = saved_data.get("scoreMultiplier", 0)
