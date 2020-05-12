extends Control

onready var AnimPlayer = $AnimationPlayer
onready var FadeRect = $FadeOut

onready var VersionLabel = $Version


func _ready():
	FadeRect.visible = true
	fade_out()
	set_version_number()


func set_version_number():
	VersionLabel.text = "Version: " + str(Global.version_number)


func fade_out():
	AnimPlayer.play("FadeOut")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


# frees the animation player if the main menu scene is exited
func _on_MainMenu_tree_exiting():
	AnimPlayer.queue_free()


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

