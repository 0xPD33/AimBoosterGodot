extends Node

# variable for how fast the targets start to shrink. 
# this value is applied to -scale.x and -scale.y of the targets
var shrink_strength = 0.11

# strength of the slow down, shrink_strength is multiplied by this value
var slowdown_strength = 0.5

var score : int = 0
var lives : int = 3
var game_time : String = ""

var hit_clicks : int = 0
var clicks : int = 0
var accuracy : float = 100

var game_over : bool = false

var sfx_volume : float = -12.0


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
	shrink_strength = 0.11
	slowdown_strength = 0.5
	
	score = 0
	lives = 3
	game_over = false
	
	hit_clicks = 0
	clicks = 0
	accuracy = 100

