extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed  # 35
var height  # 5
var bounces
var inside #true

#var direction = Vector3(0,0,0)
#var distance = Vector3(0,0,0)
onready var player
onready var ai
onready var leftHP

var hitByPlayer  # false
var enteredHitZone #false
var rng = RandomNumberGenerator.new()
onready var score
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	player = get_node("/root/Tennis Journey/Player")
	ai = get_node("/root/Tennis Journey/AI")
	score = get_node("/root/Tennis Journey/Score")
	leftHP = get_node("/root/Tennis Journey/Court/HitPoints/L")

	hitByPlayer = false
	enteredHitZone = false
	speed = 35
	height = 5
	bounces = 0
	inside = true
	rng = RandomNumberGenerator.new()
	linear_velocity.z = speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if enteredHitZone:
		Engine.time_scale = 1
		bounces = 0
		inside = false
		if linear_velocity.y > 0 :
			linear_velocity.y = 0
		if linear_velocity.y <= 0 :
			linear_velocity.y = height
		rng.randomize()
		if !hitByPlayer: #PLAYERRRRRRRRRR
			linear_velocity.z = -speed
			if Input.is_action_pressed("e"):
				var randDir = rng.randf_range(9,11)
				#linear_velocity.y += 4
				linear_velocity.x =randDir
			elif Input.is_action_pressed("ui_left"):
				linear_velocity.x = translation.x - leftHP.translation.x
			elif Input.is_action_pressed("q"):
				var randDir = rng.randf_range(-11,-9)
				linear_velocity.x =randDir
			else :
				var randDir = rng.randf_range(-2,2)
				linear_velocity.x = randDir
				
		else : #AIIIIIIIIIIIIIIIIIIIII
			linear_velocity.z = speed
			var randDir = rng.randf_range(-10,10) #-11,11
			linear_velocity.x = randDir

		hitByPlayer = !hitByPlayer
		enteredHitZone = false
		#print(linear_velocity)
func _physics_process(delta):
	if !hitByPlayer:
		if player != null:
			pass
			
			#direction = player.translation-translation
	#		if (player.translation-translation).x >= 0 :
	#			print("Left")
	#		elif (player.translation-translation).x < 0 :
	#			print("Right")
	else : 
		if ai != null:
			pass


func _on_HitZone_body_entered(body):
	if "Ball" in body.name:
		enteredHitZone = true
func _on_HitZone_body_exited(body):
	if "Ball" in body.name:
		enteredHitZone = false
	



func _on_Court_body_entered(body):
	if  "Ball" in body.name:
		inside = true
		bounces += 1 # xanei to proto bounce gia kapoio logo
		print(bounces)
		body.linear_velocity.y += 20/bounces
		Engine.time_scale = 0.5
		if bounces >= 2:
			score.pointOver(hitByPlayer)
			bounces = 0


func _on_Out_body_entered(body):
	if "Ball" in body.name:
		if bounces == 0 && !inside:
			hitByPlayer = !hitByPlayer # pffffff skataaaaaaaaaaaa
			score.pointOver(hitByPlayer)
			hitByPlayer = !hitByPlayer
			print("out")
#			if !hitByPlayer:
#				playerscore += 15
#				playerscoretext.text = "Player : " + str(playerscore)
#			elif hitByPlayer:
#				aiscore += 15
#				aiscoretext.text = "AI : " + str(aiscore)
		#bounce = 0 
