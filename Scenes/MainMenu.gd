extends Control

# simple script for the main menu

onready var AnimPlayer = $AnimationPlayer

func _ready():
	fade_out()


# the following 4 signals detect the mouse movement and 
# change the button font color on hovering in and out
func _on_PlayButton_mouse_entered():
	AnimPlayer.play("PlayHoverIn")


func _on_PlayButton_mouse_exited():
	AnimPlayer.play("PlayHoverOut")


func _on_QuitButton_mouse_entered():
	AnimPlayer.play("QuitHoverIn")


func _on_QuitButton_mouse_exited():
	AnimPlayer.play("QuitHoverOut")


func fade_out():
	AnimPlayer.play("FadeOut")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_MainMenu_tree_exiting():
	AnimPlayer.queue_free()

