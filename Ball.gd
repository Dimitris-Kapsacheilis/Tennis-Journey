extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 40
var direction = Vector3(0,0,0)
var distance = Vector3(0,0,0)
onready var player
onready var ai
var hitByPlayer = false
var enteredHitZone = false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Tennis Journey/Player")
	ai = get_node("/root/Tennis Journey/AI")
	linear_velocity.z =speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if enteredHitZone:
		if !hitByPlayer:
			if Input.is_action_pressed("e"):
				rng.randomize()
				var randDir = rng.randf_range(9,11)
				linear_velocity.x =randDir
				linear_velocity.z =-speed
				linear_velocity.y = 1
			elif Input.is_action_pressed("q"):
				rng.randomize()
				var randDir = rng.randf_range(-11,-9)
				linear_velocity.x =randDir
				linear_velocity.z =-speed

			else :
				rng.randomize()
				var randDir = rng.randf_range(-1,1)
				linear_velocity.x =randDir
				linear_velocity.z =-speed
				linear_velocity.y += 5
		else : #AIIIIIIIIIIIIIIIIIIIII
			rng.randomize()
			var randDir = rng.randf_range(-1,1) #-11,11
			linear_velocity.x =randDir
			linear_velocity.z =-speed
			linear_velocity.y += 5
		hitByPlayer = !hitByPlayer
		if !hitByPlayer:
			linear_velocity.z =speed
		enteredHitZone = false
		
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
	if body.name =="Ball":
		enteredHitZone = true
func _on_HitZone_body_exited(body):
	if body.name =="Ball":
		enteredHitZone = false
	

	#pass

