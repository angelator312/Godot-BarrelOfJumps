extends HBoxContainer

@onready var score= $Score
@onready var progressBar= $ProgressBar
@onready var coolDown=$CoolDown
@onready var lives = $Lives

func _physics_process(_delta):
	score.text = "	" + str(GlobalVariables.score) + " G"
	progressBar.value=(GlobalVariables.luckForBoss*100)/0.6
	var time = clamp(PlayerVariables.timeForSword, 0, PlayerVariables.defaultTimeToSword)
	var coolValue = (PlayerVariables.defaultTimeToSword - time)/PlayerVariables.defaultTimeToSword * 100
	coolDown.value=  coolValue
	if coolValue >= 100: 
		coolDown.tint_over = Color.WHITE
	else:
		coolDown.tint_over = Color.BLACK
	lives.value = PlayerVariables.lives*20
