extends Control

# simple script for the main menu

onready var AnimPlayer = $AnimationPlayer
onready var FadeRect = $FadeOut


func _ready():
	FadeRect.visible = true
	fade_out()


func fade_out():
	AnimPlayer.play("FadeOut")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_MainMenu_tree_exiting():
	AnimPlayer.queue_free()


