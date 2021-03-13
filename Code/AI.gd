extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# physics
var speed : float = 220.0
onready var ball

 
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
var direction = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	ball = get_node("/root/Tennis Journey/BallK") # Replace with function body.

func _physics_process (delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0

	# normalize the input so we can't move faster diagonally
		
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	 

	if ball.hitByPlayer && !ball.serve :
		direction.x = ball.translation.x - translation.x
		direction.z = 0 #(ball.translation.z - translation.z - 18) / 120
	elif !ball.hitByPlayer && !ball.serve :
		if  translation.x <= 0:
			direction.x =  -translation.x
		elif  translation.x > 0:
			direction.x =  -translation.x
		if translation.z >= -33:
			direction.z = -(ball.translation.z - translation.z - 1) / 15
		else:
			direction.z = 0
	move_and_slide(direction*delta*speed, Vector3.UP)
	
#		# jump if we press the jump button and are standing on the floor
#	if Input.is_action_pressed("sprint") and is_on_floor():
#		moveSpeed = 8
#	elif Input.is_action_just_released("sprint"):
#		moveSpeed = 4
#	if Input.is_action_pressed("jump") and is_on_floor():
#		vel.y = jumpForce

		
		
		
