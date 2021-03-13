extends KinematicBody



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = 6
var speed  # 35
var height  # 5
var bounces
var inside #true
var serve = true

#var direction = Vector3(0,0,0)
#var distance = Vector3(0,0,0)
onready var player
onready var ai
onready var leftHP
onready var centerHP
onready var rightHP
onready var myleftHP
onready var mycenterHP
onready var myrightHP

var hitByPlayer  # false
var enteredHitZone #false
var rng = RandomNumberGenerator.new()
onready var score
var dir =Vector3()
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1
	player = get_node("/root/Tennis Journey/Player")
	ai = get_node("/root/Tennis Journey/AI")
	score = get_node("/root/Tennis Journey/Score")
	leftHP = get_node("/root/Tennis Journey/Court/HitPoints/L")
	centerHP = get_node("/root/Tennis Journey/Court/HitPoints/C")
	rightHP = get_node("/root/Tennis Journey/Court/HitPoints/R")
	myleftHP = get_node("/root/Tennis Journey/Court/HitPoints/PlayerLeft")
	mycenterHP = get_node("/root/Tennis Journey/Court/HitPoints/PlayerCenter")
	myrightHP = get_node("/root/Tennis Journey/Court/HitPoints/PlayerRight")

	hitByPlayer = false
	enteredHitZone = false
	speed = 30
	height = 5
	bounces = 0
	inside = true
	rng = RandomNumberGenerator.new()
	#dir = player.translation -translation
	#dir.y = 3.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if enteredHitZone:
		Engine.time_scale = 1
		bounces = 0
		inside = false
		if serve :
			gravity = 0
			if Input.is_action_just_released("ui_accept"):
				serve = false
				print("serve")
				gravity = 6
				if score:
					if !score.adCourt :
						dir = leftHP.global_transform.origin -translation
						dir.y+= height +2
					elif score.adCourt :
						dir = rightHP.global_transform.origin -translation
						dir.y+= height +2
#		if linear_velocity.y > 0 :
#			linear_velocity.y = 0
#		if linear_velocity.y <= 0 :
#			linear_velocity.y = height
		#rng.randomize()
		elif !hitByPlayer && !serve : #PLAYERRRRRRRRRR
			if Input.is_action_pressed("ui_left"):
				dir = leftHP.global_transform.origin -translation
				dir.y+= height +2
			elif Input.is_action_pressed("ui_right"):
				dir = rightHP.global_transform.origin -translation 
				dir.y += height +2
			else : #default center if you press nothing (later only space)
				var randDir = rng.randf_range(-2,2)
				dir = centerHP.global_transform.origin -translation 
				dir.y += height +2
			if Input.is_action_pressed("ui_up"): #deep
				dir.z += -11
			if Input.is_action_pressed("ui_down"): #deep
				dir.y += 2.5
				dir.z += 25
				if dir.x <= 0 :
					dir.x += 5 
				elif dir.x >= 0 :
					dir.x -= 5 
			#rng = RandomNumberGenerator.new()
			var randDepth = rng.randf_range(-3,3) #-11,11
			dir.z += randDepth
			var randHorizontal = rng.randf_range(-4.5,4.5) #-11,11
			dir.x += randHorizontal
			print(dir)
		elif hitByPlayer && !serve : #AIIIIIIIIIIIIIIIIIIIII
			var randHP = rng.randi_range(0,2) #-11,11
			match randHP :
				0:
					dir = mycenterHP.global_transform.origin -translation
				1:
					dir = myleftHP.global_transform.origin -translation
				2:
					dir = myrightHP.global_transform.origin -translation
			#rng = RandomNumberGenerator.new()
			var randDepth = rng.randi_range(-11,11) #-11,11
			dir.z += randDepth
			var randHorizontal = rng.randf_range(-4.5,4.5) #-11,11
			dir.x += randHorizontal
			dir.y += height + 3
			#dir.y += height
			#linear_velocity.z = speed
			
			#linear_velocity.x = randDir
		#dir.y = height
		if !serve:
			hitByPlayer = !hitByPlayer
			enteredHitZone = false
		#print(linear_velocity)
	dir.y -= gravity * delta
	move_and_slide(dir*speed*delta)
	
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
		body.get_node("Particles").emitting = true
		#body.linear_velocity.y += 20/bounces
		dir.y += 4*height / bounces
		if bounces >= 2:
			score.pointOver(hitByPlayer)
			bounces = 0
		else:
			if hitByPlayer && translation.z >= 0:
				score.pointOver(!hitByPlayer)
				bounces = 0
			elif !hitByPlayer && translation.z <= 0:
				hitByPlayer = !hitByPlayer # pffffff skataaaaaaaaaaaa
				score.pointOver(hitByPlayer)
				hitByPlayer = !hitByPlayer 
				bounces = 0
			Engine.time_scale = 0.5
			yield(get_tree().create_timer(0.5), "timeout")
			Engine.time_scale = 1
		

func _on_Out_body_entered(body):
	if "Ball" in body.name:
		if bounces == 0 && !inside:
			hitByPlayer = !hitByPlayer # pffffff skataaaaaaaaaaaa
			score.pointOver(hitByPlayer)
			hitByPlayer = !hitByPlayer
			print("out")
		elif bounces == 1:
			score.pointOver(hitByPlayer)
			bounces = 0
#			if !hitByPlayer:
#				playerscore += 15
#				playerscoretext.text = "Player : " + str(playerscore)
#			elif hitByPlayer:
#				aiscore += 15
#				aiscoretext.text = "AI : " + str(aiscore)
		#bounce = 0 


func _on_Net_body_entered(body):
	if "Ball" in body.name:
		print("net")
		var randHeight = rng.randf_range(-4,4) #-11,11
		dir.y += randHeight
		if translation.y <0.8: # de ksero ama doyleyei alla kalo to blepo gia tora :D
			dir = Vector3(0,0,0)




