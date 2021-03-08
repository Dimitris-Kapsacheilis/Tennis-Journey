extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# physics
var moveSpeed : float = 30.0
var jumpForce : float = 5.0
var gravity : float = 12.0

 
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process (delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0

	var input = Vector2()

	# movement inputs
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	
	# normalize the input so we can't move faster diagonally
	input = input.normalized()
		
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	# set the velocity
	vel.z = (forward * input.y + right * input.x).z * moveSpeed
	vel.x = (forward * input.y + right * input.x).x * moveSpeed
	 
	# apply gravity
	vel.y -= gravity * delta
	 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
#		# jump if we press the jump button and are standing on the floor
#	if Input.is_action_pressed("sprint") and is_on_floor():
#		moveSpeed = 8
#	elif Input.is_action_just_released("sprint"):
#		moveSpeed = 4
#	if Input.is_action_pressed("jump") and is_on_floor():
#		vel.y = jumpForce

		
		
		
