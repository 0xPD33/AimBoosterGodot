extends Timer

var screen_size

var rand = RandomNumberGenerator.new()
var targetscene = load("res://Target/Target.tscn")

# constant for maximum targets on screen at the same time
const MAX_TARGETS = 5


# get the visible area
func get_screen_size():
	screen_size = get_viewport().get_visible_rect().size


# spawn 5 targets at the beginning of the game
func _ready():
	get_screen_size()
	for i in range (0, MAX_TARGETS):
		add_target()


# spawns new targets automatically if the game isn't over and there are under 5 targets
func _process(_delta):
	if get_child_count() < MAX_TARGETS and Global.game_over == false:
		add_target()


# creates a new instance of Target.tscn, randomizes coordinates of targets and
# adds the target as a child of the TargetSpawner node.
func add_target():
	var target = targetscene.instance()
	rand.randomize()
	var x = rand.randf_range(0 + 20, screen_size.x - 20)
	rand.randomize()
	var y = rand.randf_range(0 + 20, screen_size.y)
	
	target.position.y = y
	target.position.x = x
	
	add_child(target)
	add_to_group("Targets")


# runs every second and slightly increases the shrink_strength 
# and alter the slowdown_strength, making the game more difficult 
# in a seemingly simple way and helping the player as time progresses
func _on_TargetSpawner_timeout():
	if Global.game_over == false:
		Global.shrink_strength += 0.0007
		if Global.slowdown_strength >= 0.2:
			Global.slowdown_strength -= 0.005
		else:
			Global.slowdown_strength = 0.2

