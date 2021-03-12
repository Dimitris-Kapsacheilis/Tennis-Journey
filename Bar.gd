extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var indicator
var dir = -1
var speed = 2
var pressed = false
var fast 
var normal 
var slow 
var superslow
onready var player
onready var ball
# Called when the node enters the scene tree for the first time.
func _ready():
	indicator = $Indicator
	player = get_node("/root/Tennis Journey/Player")
	ball = get_node("/root/Tennis Journey/BallK")
	if ball:
		normal = ball.speed
		fast = 1.5 * normal
		slow = normal / 1.5
		superslow = normal / 3
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"): # && ball.bounces == 1: #activate only when bounced
		if Input.is_action_just_pressed("ui_accept"):
			indicator.rect_position.y = 119
		rect_global_position.x = 10*(player.translation.x +50)  #POLY KAKOOOOOOOOOOOOOOOOOOOOOOO
		rect_global_position.y = 10*player.translation.z 
		pressed = true
		visible = true
	if pressed:
		if indicator.rect_position.y >=119:
			dir = -1 * speed
		elif indicator.rect_position.y <=0:
			dir = 1 * speed
		indicator.rect_position.y += dir
		if Input.is_action_just_released("ui_accept"):
			match int(indicator.rect_position.y / 30) :
				0:
					ball.speed = fast
				1:
					ball.speed = normal
				2:
					ball.speed = slow
				3:
					ball.speed = superslow
			dir = 0
			pressed = false
			$BarTimer.start()
			#visible = false

			
			

func _on_BarTimer_timeout():
	visible = false # Replace with function body.
