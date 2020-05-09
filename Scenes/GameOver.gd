extends Control

onready var ScoreValue = $Panel/MarginContainer/TabContainer/Overview/VBoxContainer/VBoxContainer/ScoreValue
onready var BestValue = $Panel/MarginContainer/TabContainer/Overview/VBoxContainer/VBoxContainer/BestValue

var score_file = "user://highscore.data"
var highscores = []
var highscore : int = 0
var best_time : String = ""


# load highscores (if available) and sets the ScoreValue equal to last game's values
# and the BestValue equal to the all-time highscore and best_time
func _ready():
	load_highscores()
	
	ScoreValue.set_text("Score: " + str(Global.score) + ", Time: " + Global.game_time)
	BestValue.set_text("Score: " + str(highscore) + ", Time: " + best_time)
	
	# if the player achieved a new highscore or there is no highscore: set it!
	if Global.score > highscore or highscore == 0:
		set_highscore()
	
	Global.reset()


# set new highscore and best time
func set_highscore():
	best_time = Global.game_time
	highscore = Global.score
	save_highscore()
	
	BestValue.set_text("Score: " + str(highscore) + ", Time: " + best_time)


# save highscore values into file
func save_highscore():
	var file = File.new()
	highscores = [highscore, best_time]
	var error = file.open(score_file, File.WRITE)
	
	if error == OK:
		file.store_var(highscores)
		file.close()


# load highscore values from file
func load_highscores():
	var file = File.new()
	if file.file_exists(score_file):
		var error = file.open(score_file, File.READ)
		if error == OK:
			file.open(score_file, File.READ)
			var saved_highscores = file.get_var()
			highscores = saved_highscores
			file.close()
			highscore = highscores[0] 
			best_time = highscores[1]


# change back to Game scene
func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


# quit to main menu
func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


# resets highscore and best_time
func _on_ResetButton_pressed():
	highscore = 0
	best_time = ""
	save_highscore()
	BestValue.set_text("Score: " + str(highscore) + ", Time: " + best_time)

