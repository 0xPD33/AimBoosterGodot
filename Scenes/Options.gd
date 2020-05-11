extends Control

var sfx_volume : float

onready var SoundFXSlider = $ColorRect/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/SoundFXSlider


# sets the sliders value to the current global sfx_volume
func _ready():
	SoundFXSlider.value = Global.sfx_volume


func apply_settings():
	Global.sfx_volume = sfx_volume


# creates new variable slider_volume once the SoundFXSlider is interacted with,
# sets sfx_volume equal to slider_volume
func _on_SoundFXSlider_value_changed(value: float):
	var slider_volume = SoundFXSlider.value
	sfx_volume = slider_volume


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_ApplyButton_pressed():
	apply_settings()


func _on_OKButton_pressed():
	apply_settings()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

