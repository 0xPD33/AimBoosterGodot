extends Node

var version_number = "0.1.1"

# GAME/

# variable for how fast the targets start to shrink and grow. 
# this value is applied to -/+scale.x and -/+scale.y of the targets
var shrink_grow_strength = 0.25

# strength of the slow down, shrink_strength is multiplied by this value
var slowdown_strength = 0.7

# maximum targets on screen at the same time
var max_targets : float = 5.00

var score : int = 0
var lives : int = 3
var game_time : String = ""

var hit_clicks : int = 0
var clicks : int = 0
var accuracy : float = 100

var game_over : bool = false

# /GAME

# OPTIONS/

var sfx_volume : float = -12.0

# /OPTIONS


# had to place this part here. none of the simple implementation methods worked for me.
# i tried adding an AudioStreamPlayer into the Target scene itself, playing with signals etc,
# but the click sound wasn't playing.
func play_sound(sample: String):
	var player := AudioStreamPlayer.new()
	player.stream = load(sample)
	player.set_volume_db(sfx_volume)
	add_child(player)
	player.play()


# reset all global values
func reset():
	shrink_grow_strength = 0.25
	slowdown_strength = 0.7
	max_targets = 5.00
	
	score = 0
	lives = 3
	game_over = false
	
	hit_clicks = 0
	clicks = 0
	accuracy = 100

