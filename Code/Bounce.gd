extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("e"):
		linear_velocity.x =10
		linear_velocity.z =-10
	if Input.is_action_pressed("q"):
		linear_velocity.x =-10
		linear_velocity.z =-10
