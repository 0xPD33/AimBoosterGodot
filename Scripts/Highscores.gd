extends Tabs

var highscore = 0 setget set_highscore
const FILEPATH = "res://Highscore/Highscore.data"


func _ready():
	load_highscores()


func load_highscores():
	var file = File.new()
	if not file.file_exists(FILEPATH): return
	file.open(FILEPATH, File.READ)
	highscore = file.get_var()
	file.close()


func save_highscore():
	var file = File.new()
	file.open(FILEPATH, File.WRITE)
	file.store_var(highscore)
	file.close()


func set_highscore(new_highscore):
	highscore = new_highscore
	save_highscore()

