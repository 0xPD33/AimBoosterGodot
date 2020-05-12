extends Control

var sfx_volume : float
var custom_cursor_enabled : bool

onready var SoundFXSlider = $ColorRect/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/SoundFXSlider
onready var CustomCursorBox = $ColorRect/MarginContainer/VBoxContainer/VBoxContainer/CustomCursorCheckBox


# sets the sound sliders value to the current global sfx_volume,
# checks for custom cursor values
func _ready():
	SoundFXSlider.value = Global.sfx_volume
	
	if Global.custom_cursor_enabled == true:
		custom_cursor_enabled = true
		CustomCursorBox.pressed = true
	elif Global.custom_cursor_enabled == false:
		custom_cursor_enabled = false
		CustomCursorBox.pressed = false


func apply_settings():
	Global.sfx_volume = sfx_volume
	set_cursor()


# creates new variable slider_volume once the SoundFXSlider is interacted with,
# sets sfx_volume equal to slider_volume
func _on_SoundFXSlider_value_changed(value: float):
	var slider_volume = value
	sfx_volume = slider_volume


func _on_CustomCursorCheckBox_pressed():
	if custom_cursor_enabled == false:
		custom_cursor_enabled = true
	elif custom_cursor_enabled == true:
		custom_cursor_enabled = false


# set mouse cursor to a custom cursor (crosshair) or the default cursor,
# depending on custom_cursor_enabled value
func set_cursor():
	var custom_cursor = load("res://GFX/Crosshair.png")
	
	if custom_cursor_enabled == true:
		Input.set_custom_mouse_cursor(custom_cursor, 0, Vector2(6, 7))
		Global.custom_cursor_enabled = true
	elif custom_cursor_enabled == false:
		Global.custom_cursor_enabled = false
		Input.set_custom_mouse_cursor(null, 0)


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_ApplyButton_pressed():
	apply_settings()


func _on_OKButton_pressed():
	apply_settings()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

