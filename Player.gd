extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -320.0 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var text= $"../Text".get_child(1)
#@onready var stoper= $"../Stoper"
#@onready var restart= $"../Restart"
#@onready var but2= $"../GoToMain"
@onready var whenGameOver= $"../GameOver"
@onready var animations= $"AnimatedPlayer"
@onready var whenWon=$"../LevelWon"
var attack=false
var attackBr=0
var gameOver=false
var jumps=0
var isHited=false

func _ready():
	PlayerVariables.timeForSword=0
	PlayerVariables.lives=PlayerVariables.startLives
	#print(lives)
	animations.play("default")

func _physics_process(delta):
	if GlobalVariables.levelWon:
		animations.play("default")
		whenWon.visible=true

		return
	if(gameOver):
		if(animations.frame==11):
			#animations.autoplay="death"
			animations.stop()
			animations.frame=9
			
		return
	PlayerVariables.timeForSword-=delta
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps=0
	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and jumps<PlayerVariables.maxJumps:
		velocity.y = JUMP_VELOCITY-(PlayerVariables.plusJump*20)
		jumps+=1
		if(!attack):
			animations.play("jump")
	if Input.is_physical_key_pressed(KEY_X) and PlayerVariables.timeForSword<=0:
		attack=true
		attackBr+=1
		animations.play("attack")

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		#print(direction)
		animations.flip_h=direction==-1
		if(jumps==0 && !attack):
			animations.play("run")
		velocity.x = direction * SPEED
	else:
		if(jumps==0 && !attack):
			animations.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#animations.play("run")
	if(self.position.x<10):self.position.x=10
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider =collision.get_collider(); 
		#print(collider.name)
		if(collider.name!="Wall"):
			if(collider.has_method("addScore")):
				GlobalVariables.score+=collider.addScore()*GlobalVariables.scoreMultiplier;
				#stoper.drawScore()
				GlobalVariables.updateDeltaTime()
				#print_debug('REmoving collider', collider.get_parent())
				if(collider.get_parent()):
					self.get_parent().remove_child(collider)
			else:
				if(!attack && !isHited):
					PlayerVariables.lives-=1
					player_is_hit()
					collider.hited(attackBr)
					collider.apply_impulse(Vector2(100, 0))
				#animations.stop()
				if(PlayerVariables.lives<=0):
					animations.play("death")
					gameOver=true
					whenGameOver.visible=true
				else :
					if collider is RigidBody2D && attack:
						print(collider.health)
						print(attackBr)
						collider.hited(attackBr)
						collider.apply_impulse(Vector2(1000, 0))
					#else:
						#print(1)
					#if(collider.get_parent()):
						#self.get_parent().remove_child(collider)
					
				#restart.show()
			#print("Collided with: ", collision.get_collider().name)
		

func player_is_hit():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.RED, .5).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(end_hit_tween)
	isHited = true

func end_hit_tween():
	self.modulate = Color.WHITE
	isHited= false

func _on_animated_player_animation_looped():
	if(animations.animation=="attack"):
		attack=false
		print("Att")
		PlayerVariables.timeForSword=PlayerVariables.defaultTimeToSword
		#print(timeForSword)
	pass # Replace with function body.
