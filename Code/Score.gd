extends CanvasLayer

#onready var ball = preload("res://Ball.tscn")

onready var playerscore = 0
onready var aiscore = 0
onready var playerscoretext
onready var aiscoretext
var playergames = 0 
var aigames = 0
var playersets = 0 
var aisets = 0
var avdplayer = false
var avdai = false
var deuce = false
var adCourt = false
var playerServe = true

onready var ai
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	playerscoretext = get_node("/root/Tennis Journey/Score/Player")
	aiscoretext = get_node("/root/Tennis Journey/Score/AI")
	ai = get_node("/root/Tennis Journey/AI")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func pointOver(hitByPlayer):
	adCourt = !adCourt
	$EndPoint.start()
	
	#print(tempball.enteredHitZone)
	if hitByPlayer:
				avdai = false
				if playerscore < 30 :
					playerscore += 15
				elif playerscore == 30 :
					playerscore = 40
				elif playerscore == 40 && aiscore < 40:
					playerscore = 0
					aiscore= 0
					playergames += 1
					playerServe = !playerServe
					if playergames == 6 && aigames <=4 :
						playergames = 0
						playersets +=1
						aigames = 0
				elif deuce:
					avdplayer = true
					deuce = false
				elif avdplayer:
					playerscore = 0
					aiscore = 0
					playergames += 1
					playerServe = !playerServe
					avdplayer = false
				elif avdai :
					deuce = true
					avdai =false
	elif !hitByPlayer:
		avdplayer = false
		if aiscore < 30 :
			aiscore += 15
		elif aiscore == 30 :
			aiscore = 40
		elif aiscore == 40 && playerscore < 40:
			aiscore = 0
			playerscore= 0
			aigames += 1
			playerServe = !playerServe
			if aigames == 6 && playergames <=4 :
				aigames = 0
				aisets += 1
				playergames = 0
		elif deuce:
			avdai = true
			deuce = false
		elif avdai:
			aiscore = 0
			playerscore = 0
			aigames += 1
			playerServe = !playerServe
			avdai = false
		elif avdplayer :
			deuce = true
			avdplayer = false
		if playerscore == 40 && aiscore == 40 && !avdai && !avdai:
			deuce = true
	#bounces = 0
	playerscoretext.text = "Player : " + str(playersets) + " - " + str(playergames)+ " - "  + str(playerscore)
	if avdplayer :
		playerscoretext.text += " AD"
	aiscoretext.text = "AI : " + str(aisets) + " - " + str(aigames) + " - " + str(aiscore)
	if avdai :
		aiscoretext.text += " AD"
		
		
	#OKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
	


func _on_EndPoint_timeout():

	#pass
	Engine.time_scale = 1
	var ball = get_node("/root/Tennis Journey/BallK")
	var ai = get_node("/root/Tennis Journey/AI")
	var player = get_node("/root/Tennis Journey/Player")
	ball.serve = true
#	player.pause_mode =true
#	ai.pause_mode =true
#	ball.pause_mode =true
	if playerServe:
		if !adCourt:
				player.translation = Vector3(2.5,4.1,37)
				ai.translation = Vector3(-9,4.1,-37)	
				ball.translation = Vector3(2.5,3.8,35)
		elif adCourt:
				player.translation = Vector3(-2.5,4.1,37)
				ai.translation = Vector3(9,4.1,-37)	
				ball.translation = Vector3(-2.5,3.8,35)
		#ball.dir = player.translation - ball.translation
	if !playerServe:
		if !adCourt:
				player.translation = Vector3(9,4.1,37)
				ai.translation = Vector3(-2.5,4.1,-37)	
				ball.translation = Vector3(-2.5,3.8,-35)
		elif adCourt:
				player.translation = Vector3(-9,4.1,37)
				ai.translation = Vector3(2.5,4.1,-37)	
				ball.translation = Vector3(2.5,3.8,-35)
		#ball.dir = ai.translation - ball.translation
		#ball.linear_velocity = Vector3(0,0,0)
	
	#yield(get_tree().create_timer(0.5), "timeout")
#	player.pause_mode =false
#	ai.pause_mode =false
#	ball.pause_mode =false
	ball.hitByPlayer = false
	ball.enteredHitZone = false
	ball.inside = true
	#ball.linear_velocity.z = 35
	#ball.dir = player.translation - ball.translation
	ball.speed = 35
	ball.bounces = 0
	#ball.dir.y = 3.5
	ball.dir = Vector3(0,0,0)
	player.direction = Vector3(0,0,0)
	ai.direction = Vector3(0,0,0)
	ball.serve = true
	
	
		#get_node("/root/Tennis Journey/Player").transform.origin = Vector3(0.45,4.171,30)
		#ai.transform.origin = Vector3(0.45,4.171,-32)
