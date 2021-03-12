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
			aiscore= 0
			aigames += 1
			if aigames == 6 && playergames <=4 :
				aigames = 0
				aisets +=1
				playergames = 0
		elif deuce:
			avdai = true
			deuce = false
		elif avdai:
			aiscore = 0
			playerscore = 0
			aigames += 1
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
	if player:
		player.translation = Vector3(0,4.1,37)
	if ball:
		ball.translation = Vector3(0,2.797,36)
		#ball.linear_velocity = Vector3(0,0,0)
		ball.hitByPlayer = false
		ball.enteredHitZone = false
		ball.inside = true
		#ball.linear_velocity.z = 35
		ball.speed = 35
		ball.bounces = 0
		ball.dir = player.translation - ball.translation
		ball.dir.y = 3.5
	if ai:
		ai.translation = Vector3(0,4.1,-37)
		
	
		#get_node("/root/Tennis Journey/Player").transform.origin = Vector3(0.45,4.171,30)
		#ai.transform.origin = Vector3(0.45,4.171,-32)
