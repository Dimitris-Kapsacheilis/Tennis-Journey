extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene("res://Scenes/Tennis Journey.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_Exit_pressed():
	get_tree().quit()



func _on_Continue_pressed():
	get_tree().change_scene("res://Scenes/Tennis Journey.tscn")
