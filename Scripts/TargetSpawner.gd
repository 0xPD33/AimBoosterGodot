extends Timer

var screen_size

var rand = RandomNumberGenerator.new()
var targetscene = load("res://Target/Target.tscn")


# get the visible area
func get_screen_size():
	screen_size = get_viewport().get_visible_rect().size


# spawn 5 targets at the beginning of the game
func _ready():
	get_screen_size()
	for i in range (0, Global.max_targets):
		add_target()


# spawns new targets automatically if the game isn't over and there are under 5 targets
func _process(_delta):
	if get_child_count() < Global.max_targets and Global.game_over == false:
		add_target()


# creates a new instance of Target.tscn and sets it up
func add_target():
	var target = targetscene.instance()
	
	target.position.x = randomize_position("x")
	target.position.y = randomize_position("y")
	
	target.scale.x = 0.02
	target.scale.y = 0.02
	
	add_child(target)
	add_to_group("Targets")


# randomizes coordinates of targets
func randomize_position(xy):
	if xy == "x":
		rand.randomize()
		var x = rand.randf_range(0 + 20, screen_size.x - 20)
		return x
	
	if xy == "y":
		rand.randomize()
		var y = rand.randf_range(0 + 20, screen_size.y)
		return y


# runs every second and slightly increases the shrink_strength,
# alters the slowdown_strength and increases max_targets, making the game more difficult 
# in a seemingly simple way and helping the player as time progresses
func _on_TargetSpawner_timeout():
	if Global.game_over == false:
		Global.max_targets += 0.01
		Global.shrink_grow_strength += 0.001
		if Global.slowdown_strength >= 0.3:
			Global.slowdown_strength -= 0.005
		else:
			Global.slowdown_strength = 0.3

