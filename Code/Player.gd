extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# physics
var moveSpeed : float = 30.0
var jumpForce : float = 5.0
var gravity : float = 12.0
onready var ball
var speed : float = 220.0
var direction = Vector3()
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 

# Called when the node enters the scene tree for the first time.
func _ready():
	ball = get_node("/root/Tennis Journey/BallK") # Replace with function body.

func _physics_process (delta):
	if !ball.hitByPlayer && !ball.serve: 
		if ball.dir.x>= 0 &&  (ball.translation.x - translation.x>=-2 || ball.bounces == 1):
			direction.x = ball.translation.x - translation.x
		elif ball.dir.x<= 0 && (ball.translation.x - translation.x<=2 || ball.bounces == 1):
			direction.x = ball.translation.x - translation.x
		direction.z =(ball.translation.z - translation.z + 25) / 15
	elif ball.hitByPlayer && !ball.serve: # perimeno to ai
		if  translation.x <= 0:
			direction.x =  -translation.x
		elif  translation.x > 0:
			direction.x =  -translation.x
		if translation.z < 35:
			direction.z = -(ball.translation.z - translation.z - 1) / 15
		elif translation.z > 36:
			direction.z = (ball.translation.z - translation.z - 1) / 15
		else :
			direction.z  = 0 
			
	if get_node("iziman/AnimationPlayer").current_animation != "forehand" &&  get_node("iziman/AnimationPlayer").current_animation != "backhand":
		#print(direction)
		var error = 1.3
		#if (direction.x <= error && direction.x >= -error) && (direction.z <= error &&direction.z>= -error)||(translation.x == 0 && translation.z == 35):
		if direction == Vector3.ZERO || (abs(direction.x) <= error && abs(direction.z)<=error):
			get_node("iziman/AnimationPlayer").play("idle")
		else:
				get_node("iziman/AnimationPlayer").play("run")

	move_and_slide(direction*delta*speed, Vector3.UP)
#	vel.x = 0
#	vel.z = 0
#	var input = Vector2()
#	if Input.is_action_pressed("ui_up"):
#		input.y -= 1
#	if Input.is_action_pressed("ui_down"):
#		input.y += 1
#	if Input.is_action_pressed("ui_left"):
#		input.x -= 1
#	if Input.is_action_pressed("ui_right"):
#		input.x += 1
#	input = input.normalized()
#	var forward = global_transform.basis.z
#	var right = global_transform.basis.x
#	vel.z = (forward * input.y + right * input.x).z * moveSpeed
#	vel.x = (forward * input.y + right * input.x).x * moveSpeed
#	vel.y -= gravity * delta
#	vel = move_and_slide(vel, Vector3.UP)
	
#		# jump if we press the jump button and are standing on the floor
#	if Input.is_action_pressed("sprint") and is_on_floor():
#		moveSpeed = 8
#	elif Input.is_action_just_released("sprint"):
#		moveSpeed = 4
#	if Input.is_action_pressed("jump") and is_on_floor():
#		vel.y = jumpForce

		
	
