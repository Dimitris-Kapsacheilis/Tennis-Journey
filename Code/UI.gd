extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Tennis Journey.tscn")


func _on_Pause_pressed():
		get_tree().paused = !get_tree().paused
		get_node("ColorRect").visible = !get_node("ColorRect").visible


func _on_Sound_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)



func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
